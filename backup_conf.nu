
cd $"($env.HOME)/Documents/pams_cachyOS/minimal-config"
let dirs = (fd -t dir -d 1 --format '{/}' | lines)
do {
cd $"($env.HOME)/.config"
let matching_dirs = (
    ls 
    | where type == "dir" 
    | where name in $dirs
    | get name
)
mkdir config_backup
$matching_dirs | each { mv $in $"config_backup/($in).bak"}
}
# fd -d 1 -x cp -fr {} ~/.config
cp -fr ./* ~/.config
