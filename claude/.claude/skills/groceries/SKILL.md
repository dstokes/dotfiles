---
name: groceries
description: Build a grocery list from recipe links and ingredients, adding them to Todoist.
---

# Grocery List Builder

Parse recipe links and ingredient lists, consolidate quantities, and add items to the "Groceries 🛒" Todoist project organized by store section.

## Input

User provides: $ARGUMENTS

Input can include:
- One or more recipe URLs
- Specific ingredients (e.g., "a dozen eggs", "2 lbs chicken thighs")
- Notes about where to buy something (e.g., "get butter at Costco")
- Any combination of the above

## Phase 1: Parse Input

Identify:
1. **Recipe URLs** — any valid URLs to fetch ingredients from
2. **Standalone ingredients** — items listed directly by the user
3. **Store hints** — if the user specifies where to buy something (e.g., "from Costco"), note that for section assignment

## Phase 2: Fetch Recipes

For each recipe URL:
1. Use `WebFetch` to retrieve the page
2. Ask the model to extract the **full ingredient list** with quantities, units, and item names
3. Also extract the **recipe name** for reference

Parse each ingredient into structured form:
- **quantity** (number)
- **unit** (cups, lbs, oz, tablespoons, etc.)
- **item** (the ingredient name, normalized — e.g., "yellow onion" not "1 large yellow onion, diced")
- **preparation notes** (diced, minced, etc. — keep for reference but don't include in task title)

## Phase 3: Consolidate Ingredients

Combine ingredients across all recipes and standalone items:

1. **Normalize names** — treat "yellow onion" and "onion" as the same; "chicken breast" and "boneless skinless chicken breast" as the same
2. **Sum quantities** for matching ingredients:
   - Countable items: "2 onions" + "1 onion" = "3 onions"
   - Measured items: "1 cup flour" + "2 cups flour" = "3 cups flour"
   - If units differ but are convertible, convert (e.g., 8 oz + 1 cup of milk)
   - If units differ and aren't easily convertible, list both (e.g., "1 bunch cilantro + 2 tbsp cilantro")
3. **Flag pantry staples** — items the user likely already has (see Pantry Staples section)

## Phase 4: Categorize by Section

Assign each ingredient to the appropriate section in the project. Always fetch existing sections from the project first and use them.

The project's current sections (these may change over time — always fetch dynamically):

| Section | Examples |
|---------|----------|
| 🥬 Fruits • Vegetables | Fruits, vegetables, fresh herbs, garlic, onions, potatoes |
| 🍞 Bread • Bakery | Bread, tortillas, buns, rolls |
| 🧀 Deli • Dairy | Milk, cheese, butter, yogurt, eggs, deli meats, chicken, beef, pork, fish, seafood |
| 🍝 Pasta • Rice • Cereal | Pasta, rice, cereal, oats, grains, noodles |
| 🌭 Sauces • Condiments | Ketchup, soy sauce, hot sauce, salad dressing, vinegar, mustard |
| 🥨 Chips • Crackers • Nuts | Snack items, chips, crackers, nuts, trail mix |
| 🌮 World Foods • Beans | Canned beans, tortillas, salsa, curry paste, coconut milk, international ingredients |
| 🍪 Baking • Spices | Flour, sugar, baking powder, vanilla, spices, cocoa |
| ❄️ Frozen Foods | Frozen vegetables, ice cream, frozen meals |
| 🚚 Costco | Items the user specifically says to get at Costco |

**Important**: The "🚚 Costco" section is for items explicitly requested from Costco. Do not auto-assign items there unless the user indicates it.

If an ingredient doesn't clearly fit an existing section, add it to the project root (no section). Never create new sections.

## Phase 5: Confirm Pantry Staples

Before adding everything, use `AskUserQuestion` to confirm pantry staples the user might already have.

### Pantry Staples (likely already owned)

Common items to confirm:
- **Oils & fats**: olive oil, vegetable oil, cooking spray, sesame oil
- **Spices**: salt, pepper, garlic powder, onion powder, paprika, cumin, chili powder, oregano, cinnamon, red pepper flakes, bay leaves, Italian seasoning
- **Baking**: flour, sugar, brown sugar, baking soda, baking powder, vanilla extract
- **Condiments**: soy sauce, vinegar (white, apple cider, balsamic), Worcestershire sauce, hot sauce, mustard, ketchup
- **Staples**: rice, pasta, chicken/vegetable broth, canned tomatoes, tomato paste, dried beans

Present them grouped logically and let the user deselect items they actually need to buy. Only ask about items that appear in the ingredient list — don't ask about every possible staple.

Use good judgment: if a recipe calls for "2 tablespoons olive oil," that's worth confirming. If it calls for "3 cups of rice," the user probably needs to buy rice.

## Phase 6: Add to Todoist

### Project

The "Groceries 🛒" project ID is `6Crfg47frcF8xX2r`. Use this directly — do NOT create a new project.

### Load Sections

1. Fetch all sections with `find-sections` for the project
2. Map section names to IDs for task assignment
3. If an ingredient doesn't match any section, omit the section (add to project root)

### Create Tasks

For each ingredient (after pantry staple confirmation):

1. **Task content**: Use a clean format — quantity + unit + item name
   - "3 yellow onions"
   - "2 lbs chicken thighs"
   - "1 can (15 oz) black beans"
   - "1 bunch cilantro"
2. **Task description**: Always include which recipe(s) need this ingredient using the format `For: <recipe name>`.
   - From a recipe: "For: Butter Tofu"
   - Multiple recipes: "For: Butter Tofu, Thai Basil Stir Fry"
   - Standalone ingredients (no recipe URL): omit the description
3. **Section**: Assign to the appropriate section ID
4. **Priority**: Use default priority (p4) — no need to prioritize groceries

Use `add-tasks` to batch-create tasks efficiently.

### Merge with Existing Items

Before creating tasks, use `find-tasks` to fetch all existing items in the project. For each new ingredient, check if a matching item already exists (normalize names — "1 lemon" matches "lemon", "2 lemons", etc.):

- **Match found**: Use `update-tasks` to update the existing task. Combine quantities and rewrite the task content with the new total (e.g., existing "1 lemon" + new "1 lemon" → update to "2 lemons"). Append the new recipe to the description.
- **No match**: Create a new task as usual with `add-tasks`.

This ensures the grocery list never has duplicate items — quantities are always consolidated into a single task per ingredient.

## Guidelines

- **Be smart about consolidation** — "garlic" from one recipe and "3 cloves garlic" from another should combine, not duplicate
- **Round up** — if total is 2.5 onions, suggest 3
- **Respect user overrides** — if the user says "skip the cilantro" or "I need extra butter," honor that
- **Keep task names scannable** — short, no prep notes in the title (save those for description if relevant)
- **Don't over-ask** — only confirm pantry staples that actually appear in the recipes, and group the confirmation into one question when possible
