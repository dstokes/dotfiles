#!/bin/bash

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xset r rate 275 30
