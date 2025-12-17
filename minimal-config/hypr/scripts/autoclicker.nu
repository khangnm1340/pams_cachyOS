let lock_file = "/tmp/nu_autoclicker.pid"

if ($lock_file | path exists) {
    kill (cat $lock_file | into int)
    rm $lock_file
} else {
    $nu.pid | save -f ($lock_file)
    while true {
        wlrctl pointer click left
        # notify-send "hi"
        sleep 0.01sec
    }
}
