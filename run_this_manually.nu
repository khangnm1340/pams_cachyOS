cd ~/.config/nushell/
use nupm/nupm
nupm install nupm --force --path
nupm install --path nu_plugin_desktop_notifications -f  



mkdir ~/.local/share/icons/hicolor/22x22/apps/

# Link a Papirus icon to the name it's looking for
ln -s /usr/share/icons/Papirus/22x22/apps/accessories-text-editor.svg ~/.local/share/icons/hicolor/22x22/apps/wayscriber.svg
