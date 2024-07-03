#!/bin/bash

source /etc/lightdm/Wallpaper/Wallpaper.conf
now=$(date +%Y%m%d)
if [ "$(($(date +%s -d "$now")-$(date +%s -d "$lastchange")))" -ge "86400" ]; then
    i=0
    broke=false
    began=true
    firstImage=""
    image=""
    ((current=current+1))
    for entry in "$images"/*
    do
        if [ "$began" == true ]; then
            firstImage=$entry
            began=false
        fi
        image="$entry"
        if [ "$i" == "$current" ]; then
#             cp Wallpaper.conf /tmp/
#             sed -i "s/\(current *= *\).*/\1"$current"/" /tmp/Wallpaper.conf
#             cat /tmp/Wallpaper.conf>./Wallpaper.conf
#             sed -i "s/\(lastchange *= *\).*/\1"$now"/" /tmp/Wallpaper.conf
#             cat /tmp/Wallpaper.conf>./Wallpaper.conf
            broke=true
            break
        else
            ((i=i+1))
        fi
    done
    if [ "$broke" == false ]; then
        current=0
        image=$firstImage
    fi
    sed -i "s/\(current *= *\).*/\1"$current"/" /etc/lightdm/Wallpaper/Wallpaper.conf
    sed -i "s/\(lastchange *= *\).*/\1"$now"/" /etc/lightdm/Wallpaper/Wallpaper.conf
    ln -sf $image /etc/lightdm/Wallpaper/image
fi
