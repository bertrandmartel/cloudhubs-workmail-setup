#!/bin/bash

function check_config() {
    dt=$(date '+%d/%m/%Y %H:%M:%S')
    echo "$dt - running config update check"
    find /hab/pkgs/mozillareality/reticulum/** -name config.toml -print0 | while read -d $'\0' file
    do
    if grep -q "tls = \":if_available\"" "$file"; then
        echo "$dt - config is up to date"
        break
    fi
    sed  -i '/\[ret\.\"Elixir\.Ret\.Mailer\"\]/,/.*cfg\.email\.password.*/d' "$file"
    echo '

[ret."Elixir.Ret.Mailer"]
server = {{ toToml cfg.email.server }}
port = 465
tls = ":if_available"
ssl = "true"
username = {{ toToml cfg.email.username }}
password = {{ toToml cfg.email.password }}
' >> "$file"
    echo "$dt - config was updated"
    systemctl restart bio
    echo "$dt - bio was restarted"
    done
}

while true
do 
    check_config
    sleep 30
done




