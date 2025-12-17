#!/bin/bash

if nordvpn status | rg -qi '^Status:\s*Connected'; then
/usr/bin/nu -c 'notify -t "Hoo~ooh~ooh~ooh~~" --summary "Disconnecting Nordvpn..." -i ($env.MISC)/angy-hanni.jpg'
  nordvpn d
else
/usr/bin/nu -c 'notify -t "Hoo~ooh~ooh~ooh~~" --summary "Connecting Nordvpn..." -i ($env.MISC)/sadbeni.jpg'
  uwsm-app -- nordvpn c US
fi
