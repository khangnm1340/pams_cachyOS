# clone the config first
let packages = [
    neovim-git, neovide, zed , tree-sitter-cli, sudo-rs, loupe, mediainfo,
    swww, cliphist, ouch, fzf , zoxide, mpv, starship, lazygit,
    ghostty, alacritty, nordvpn-bin , tmux, vivid, localsend-bin,
    qutebrowser, helium-browser-bin, telegram-desktop,
    walker-bin, elephant-bin, elephant-all-bin,
    thunderbird, qbittorrent,
    yazi, nautilus, zathura, jrnl, atuin,
    waybar, swaync, swayimg, nomacs
    ttf-jetbrains-mono-nerd , ttf-cascadia-mono-nerd, woff2-font-awesome, ark-pixel-font,
    hyprlock, hyprpicker, hypridle ,
    xdg-desktop-portal-hyprland, xdg-desktop-portal-gnome, xdg-desktop-portal-gtk, hyprpolkitagent, wayscriber-bin, 
    kanata-bin, whitesur-icon-theme,
    # spotify, spicetify-cli,
    fcitx5, fcitx5-configtool,
    xdg-desktop-portal-termfilechooser-hunkyburrito-git, mcomix,
    zathura ,zathura-cb ,zathura-pdf-mupdf , calc, uutils-coreutils
]
# quickshell-git qt5-svg qt6-svg qt6-imageformats qt5-imageformats qt6-multimedia qt5-multimedia qt6-5compat unixodbc dgop

yay -S --needed ...$packages --noconfirm

let dirs = [ $"($env.HOME)/.local/share/fcitx5/themes/" , $"($env.HOME)/.local/share/icons" , $"($env.HOME)/.local/share/atuin/", $"($env.XDG_DATA_HOME)/applications" ]
# , $"($env.HOME)/.local/share/nvim/site/pack/core/opt"

cd $"($env.HOME)/Documents/pams_cachyOS"
$dirs | each { mkdir $in }
cp -r ./misc $"($env.HOME)/Documents/"
cp -r ./desktop-applications/* $"($env.XDG_DATA_HOME)/applications"
#(needs to be a relative or absolute path for * to work)




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


# desktop applications


#spotify theme
# curl -fsSL https://raw.githubusercontent.com/Astromations/Hazy/main/install.sh | sh

#pixiv authentication

# reproduce again
# let dirs = [ $"($env.HOME)/.local/share/fcitx5/themes/" , $"($env.HOME)/.local/share/icons" , $"($env.HOME)/.local/share/atuin/", $"($env.HOME)/.local/share/nvim/" ]
# $dirs | each { rm -rf $in}
# rm -rf $"($env.HOME)/.config/config_backup"
# rm -rf $"($env.HOME)/builds"
