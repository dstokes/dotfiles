#!/bin/bash

tmux start-server
tmux new-session -d -s code -c ~/Code
tmux new-session -d -s personal -c ~/Code

tmux attach-session -d -tcode
