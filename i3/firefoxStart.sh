#!/bin/bash

firefox --class "Firefox" &
firefox -P $social --class $social -new-window "https://web.telegram.org/k/" &
firefox -P $social --class $social -new-window "https://teams.microsoft.com/?client=pwa" &
firefox -P $social --class $social -new-window "https://outlook.office365.com/mail" &
firefox -P $music --class $music -new-window "!yt" &
