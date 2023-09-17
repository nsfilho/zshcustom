#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15
type="$HOME/.config/rofi/applets/type-1"
style='style-1'

## Run
option=$(echo -e "Sim\nNão" | rofi \
    -p "Deseja recarregar as configurações?" \
    -dmenu \
    -theme ${type}/${style}.rasi)

if [[ $option == "Sim" ]]; then
    # Launch Rofi
    i3-msg reload
fi
