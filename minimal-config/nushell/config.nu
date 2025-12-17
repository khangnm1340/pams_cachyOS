# config.nu
#
# Installed by:
# version = "0.106.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config = {

    edit_mode: vi # emacs, vi
    table: {
        mode: compact # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    }
    keybindings: [
      {
            name: quick_cd
            modifier: shift
            keycode: char_z
            mode: [emacs vi_normal vi_insert]
            event: { 
                  send: executehostcommand,
                  cmd: "cd (fd --type d | fzf --preview 'eza {}')" }
      }
      {
            name: quick_cd
            modifier: alt
            keycode: char_k
            mode: [emacs vi_normal vi_insert]
            event: { 
                  send: executehostcommand,
                  cmd: "cd (cat ~/.config/nushell/cd_history.txt | fzf)" }
      }
	  {
            name: last_cd
            modifier: shift
            keycode: char_l
            mode: [emacs vi_normal vi_insert]
            event: { send: executehostcommand, cmd: "cd -" }
      }
      {
            name: cd_into_clipboard
            modifier: control
            keycode: char_v
            mode: [emacs vi_normal vi_insert]
            event: { send: executehostcommand, cmd: "cd (wl-paste)" }
      }

      {
            name: reload_config
            modifier: control
            keycode: char_x
            mode: [emacs vi_normal vi_insert]
            event: { send: executehostcommand, cmd: $"source \'($nu.env-path)\';source \'($nu.config-path)\'" }
      }
      {
            name: fzf_file
            modifier: control
            keycode: char_f
            mode: [emacs vi_normal vi_insert]
            event: { 
                  send: executehostcommand,
                  cmd: "commandline edit $'(commandline | str trim --right) \"(eza | fzf)\"'" }
      }
      {
            name: fzf_history
            modifier: Control_Shift
            keycode: char_o
            mode: [emacs vi_normal vi_insert]
            event: { 
                  send: executehostcommand,
                  cmd: "password" 
            }
      }
      {
            name: fzf_history
            modifier: Control_Alt
            keycode: char_r
            mode: [emacs vi_normal vi_insert]
            event: { 
                  send: executehostcommand,
                  cmd: "commandline edit ( history | uniq |  reverse | get command | str join $'(char nul)' | fzf --read0 --gap -q (commandline))" 
            }
      }
      {
            name: yazi
            modifier: alt
            keycode: char_j
            mode: [emacs vi_normal vi_insert]
            event: { 
                  send: executehostcommand,
                  cmd: "y" }
      }
      {
            name: delete_to_beginning_vi_insert
            modifier: control
            keycode: char_u
            mode: [vi_normal vi_insert]
            event: { edit: CutFromStart }
      }
    {
      name: "multi_line_newline"
      modifier: shift
      keycode: char_j
      mode: ["emacs", "vi_insert"]
      event: { edit: InsertNewline }
    }
	  
    ]
}



def kil [ task: string ] {
    let procs = (ps)
    let selected_name = ($procs | where name =~ $task | get name | uniq | to text | fzf)
    $procs | where name == $selected_name | get pid | first | kill $in

}

# def jo [] {
#     uwsm-app -- nu -c "job spawn {$in}"
# }


def count-files [--sum(-s)] {
  let dirs = (
      ls -a
      | where type == dir
      | insert file_count {|row|
          fd -HI --type f . $row.name
          | lines
          | length
      }
      | sort-by file_count
  )

  if $sum {
      $dirs | get file_count | math sum
  } else {
      $dirs
  }
}


use std/dirs
use std formats *
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	uwsm-app -- yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

def "notify on done" [
    task: closure
] {
    let start = date now
    let result = do $task
    let end = date now
    let total = $end - $start | format duration sec
    let body = $"Task completed in ($total)"
    notify -s "Task Finished" -t $body
    return $result
}


const NU_PLUGIN_DIRS = [
  ($nu.current-exe | path dirname)
  ...$NU_PLUGIN_DIRS
]

alias jkl = uwsm-app -- yt-dlp -f bestvideo+bestaudio --embed-subs --sub-langs "en" --remote-components ejs:github
alias jkh = uwsm-app -- yt-dlp -f "bestvideo[height<=?1080]+bestaudio" --embed-subs --sub-langs "en" --remote-components ejs:github
alias gl = gallery-dl
alias wk = gallery-dl -D .
alias sudo = sudo-rs
alias su = su-rs
alias grep = uwsm-app -- rg
alias lsa = uwsm-app -- eza -alh --group-directories-first --icons=auto
alias lta = uwsm-app -- eza -a --tree --level=2 --long --icons --git
# alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
# alias k = cd (cat ~/.config/nushell/cd_history.txt | fzf)
alias wg2 = wget2 -m -p -E -k -np --no-robots
# alias wpe = wget2 -p -E
alias nvim = uwsm-app -- nvim
alias n = uwsm-app -t service  -- neovide
alias w = uwsm-app -- wget2 --cut-file-get-vars
alias ff = uwsm-app -- fastfetch
alias jo = uwsm-app -- nu -c 'job spawn {$in}'
alias j = uwsm-app -t service --
alias peak = bash -c "paste <(jack_meter -n -f 10 'Easy Effects Sink:monitor_FL') <(jack_meter -n -f 10 'Easy Effects Sink:monitor_FR')"
ka = sudo kanata -c ($env.HOME)/.config/kanata/2config.kdb


alias f = plocate -i
alias codex = uwsm-app -- codex
alias jl = jupyter lab
# alias windows = docker compose -f ~/builds/winapps/compose.yaml up -d


# source ~/dotfiles/pamsdots/dot-config/nushell/nu_scripts/themes/nu-themes/github-light-default.nu
source $"($nu.config-path | path dirname)/custom_scripts/uutils_alias.nu"
source $"($nu.config-path | path dirname)/custom_scripts/polars_alias.nu"
source ~/.zoxide.nu

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ~/.local/share/atuin/init.nu
