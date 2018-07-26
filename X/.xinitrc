#!/bin/bash

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xset r rate 200 25
