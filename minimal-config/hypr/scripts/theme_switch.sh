#!/bin/bash

# Get the current color scheme
current_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)

# Toggle the color scheme
if [ "$current_scheme" == "'prefer-light'" ]; then
      notify-send "Switched to dark mode."
      gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
      sed -i "s/'light'/'dark'/" /home/pampam/dotfiles/dot-config/qutebrowser/config.py
      sed -i "s/darkmode.enabled = False/darkmode.enabled = True/" /home/pampam/dotfiles/dot-config/qutebrowser/config.py
      qutebrowser :config-source
elif [ "$current_scheme" == "'prefer-dark'" ]; then
      notify-send "Switched to light mode."
      gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
      sed -i "s/'dark'/'light'/" /home/pampam/dotfiles/dot-config/qutebrowser/config.py
      sed -i "s/darkmode.enabled = True/darkmode.enabled = False/" /home/pampam/dotfiles/dot-config/qutebrowser/config.py
      qutebrowser :config-source
else
      notify-send "Error: Unknown color scheme '$current_scheme'."
fi

exit 0
