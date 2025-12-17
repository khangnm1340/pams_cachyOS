# atuin
atuin init nu | save -f ~/.local/share/atuin/init.nu

#starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

#nushell
cd $"($env.HOME)/.config/nushell"
git clone https://github.com/nushell/nupm.git
git clone https://github.com/FMotalleb/nu_plugin_desktop_notifications.git  

cd ~/builds
./fcitx5/enable-rounded.sh;
cp -r ./fcitx5/src/* ~/.local/share/fcitx5/themes
cp -r ./future-cyan-hyprcursor/Future-Cyan-Hyprcursor_Theme ~/.local/share/icons

# do {
#     cd ~/.local/share/nvim/site/pack/core/opt ; git clone https://github.com/mason-org/mason-lspconfig.nvim
# }

yay
