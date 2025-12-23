let module_waybar = [
    waybar, swww, impala, swaync, hyprlock, hypridle
]

let module_caelestia = [
    caelestia-cli, caelestia-shell
]


# clone the config first
let packages = [
    neovim-git, neovide, zed , tree-sitter-cli, sudo-rs, loupe, mediainfo,
    cliphist, ouch, fzf , zoxide, mpv, starship, lazygit,
    ghostty, alacritty, nordvpn-bin , tmux, vivid, localsend-bin,
    qutebrowser, helium-browser-bin, telegram-desktop,
    walker-bin, elephant-bin, elephant-desktopapplications-bin, elephant-archlinuxpkgs-bin,
    elephant-clipboard-bin, elephant-symbols-bin, elephant-runner-bin, elephant-files-bin, elephant-menus-bin,
    thunderbird, qbittorrent, pwvucontrol, 
    hyprpicker, hyprshot, iwd, ntfs-3g ,
    yazi, nautilus, zathura, jrnl, atuin,
    swayimg, nomacs, woff2-font-awesome,
    ttf-jetbrains-mono-nerd , ttf-cascadia-mono-nerd, ark-pixel-font, papirus-icon-theme, 
    xdg-desktop-portal-hyprland, xdg-desktop-portal-gnome, xdg-desktop-portal-gtk, hyprpolkitagent, wayscriber-bin, 
    kanata-bin, whitesur-icon-theme, ttf-material-symbols-variable, 
    # spotify, spicetify-cli,
    fcitx5, fcitx5-configtool, fcitx5-unikey,
    xdg-desktop-portal-termfilechooser-hunkyburrito-git, mcomix,
    zathura ,zathura-cb ,zathura-pdf-mupdf , qalculate-qt, uutils-coreutils
]
# quickshell-git qt5-svg qt6-svg qt6-imageformats qt5-imageformats qt6-multimedia qt5-multimedia qt6-5compat unixodbc dgop

print "Would you like caelestia(1) or waybar(2)?"
let choice = (input "'1' default : ")

if $choice == "2" {
    mv $"($env.HOME)/.config/hypr/hyprland_waybar.conf" $"($env.HOME)/.config/hypr/hyprland.conf" 
    yay -S --needed ...$packages ...$module_waybar --noconfirm
    sudo systemctl disable --now NetworkManager
    sudo systemctl enable --now iwd
# Ensure iwd service will be started
    # sudo systemctl enable iwd.service
} else {
    mv $"($env.HOME)/.config/hypr/hyprland_caelestia.conf" $"($env.HOME)/.config/hypr/hyprland.conf" 
    yay -S --needed ...$packages ...$module_caelestia --noconfirm
}

let dirs = [ $"($env.HOME)/.local/share/fcitx5/themes/" , $"($env.HOME)/.local/share/icons" , $"($env.HOME)/.local/share/atuin/", $"($env.HOME)/.local/share/applications", $"($env.HOME)/Pictures/Wallpapers"]
# , $"($env.HOME)/.local/share/nvim/site/pack/core/opt"

cd $"($env.HOME)/Documents/pams_cachyOS"
$dirs | each { mkdir $in }
cp -r ./misc $"($env.HOME)/Documents/"
cp -r ./desktop-applications/* $"($env.XDG_DATA_HOME)/applications"
#(needs to be a relative or absolute path for * to work)
cp ./misc/kangel_12x.png $"($env.HOME)/Pictures/Wallpapers"





# yazi
ya pkg add ndtoan96/ouch
ya pkg add lpanebr/yazi-plugins:first-non-directory
ya pkg add BennyOe/tokyo-night
ya pkg add yazi-rs/plugins:full-border
ya pkg add TD-Sky/sudo
ya pkg add boydaihungst/mediainfo


# add a check here
cd $"($env.HOME)/builds" ;
git clone https://github.com/catppuccin/fcitx5.git;
git clone https://gitlab.com/Pummelfisch/future-cyan-hyprcursor.git;



git config pull.rebase false

# desktop applications


#spotify theme
# curl -fsSL https://raw.githubusercontent.com/Astromations/Hazy/main/install.sh | sh
# spicetify backup apply

#pixiv authentication

# reproduce again
# let dirs = [ $"($env.HOME)/.local/share/fcitx5/themes/" , $"($env.HOME)/.local/share/icons" , $"($env.HOME)/.local/share/atuin/", $"($env.HOME)/.local/share/nvim/" ]
# $dirs | each { rm -rf $in}
# rm -rf $"($env.HOME)/.config/config_backup"
# rm -rf $"($env.HOME)/builds"
