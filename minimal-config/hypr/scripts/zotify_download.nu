
def zotify-album [album_link: string] {

let CLIENT_ID = "f70a171502544b9ba9b701a0c7e1a04c"
let CLIENT_SECRET = "ce619d57d54f425aacdb1bd376a76279"

let TOKEN = (curl -s -u $"($CLIENT_ID):($CLIENT_SECRET)" -d grant_type=client_credentials https://accounts.spotify.com/api/token | from json | get access_token)

let ALBUM_ID = ( $album_link | split row "?" | get 0 | split row "/" | last)
mut all = []
mut url = $"https://api.spotify.com/v1/albums/($ALBUM_ID)/tracks?limit=50" 
while $url != null {
let uris = (http get -H {Authorization: $"Bearer ($TOKEN)"} $url)
  let items = ($uris.items.uri)
  # append items to all
  $all = ($all ++ $items)
  $url = $uris.next
}

zotify --lyrics-file ...$all
}

def notify-result [outcome] {
    if $outcome.exit_code == 0 {
        notify-send "Downloaded!!" -t 3000
    } else {
        # output the error if it failed
        notify-send "Error Occurred" $outcome.stderr -t 3000
    }
}


let url = (wl-paste)

let outcome = if ($url =~ "^https://open.spotify.com/album" or $url =~ "^spotify:album:") {
    notify-send $"Downloading Album: ($url)" -t 3000
    # The result of this line is returned to 'outcome'
    do { zotify-album $url } | complete 
    # do {zotify} | complete 

} else if ($url =~ "^https://open.spotify.com/track" or $url =~ "^spotify:track:") {
    notify-send $"Downloading Track: ($url)" -t 3000
    do {zotify --lyrics-file $url} | complete

} else {
    notify-send "Invalid URL" -t 2000
    # Return nothing (null) so we can check for it later
    null
}

if $outcome != null {
    notify-result $outcome
}


