# Workmail SMTP config for Mozilla cloudhubs 

The following parameters needs to be set in the reticulum configuration located in `/hab/pkgs/mozillareality/reticulum/xxxxx/xxxxxx/config/config.toml` :

```
[ret."Elixir.Ret.Mailer"]
server = {{ toToml cfg.email.server }}
port = 465
tls = ":if_available"
ssl = "true"
username = {{ toToml cfg.email.username }}
password = {{ toToml cfg.email.password }}
```

The following will setup a service that will check if the config is up to date & update the config accordingly:

```bash
cp update_config_start.sh /bin/
chmod 0755 /bin/update_config_start.sh
cp update_config_stop.sh /bin/
chmod 0755 /bin/update_config_stop.sh
cp update_config.sh /bin/
chmod 0755 /bin/update_config.sh
cp update_config.service /etc/systemd/system/update_config.service
chmod 0644 /etc/systemd/system/update_config.service

systemctl enable update_config
```