# AWS Workmail SMTP config for Mozilla Cloudhubs 

The following parameters need to be set in the [reticulum](https://github.com/mozilla/reticulum) configuration located in `/hab/pkgs/mozillareality/reticulum/xxxxx/xxxxxx/config/config.toml` :

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
git clone https://github.com/bertrandmartel/cloudhubs-workmail-setup.git
cd cloudhubs-workmail-setup
cp update_config_start.sh /bin/
cp update_config_stop.sh /bin/
cp update_config.sh /bin/
cp update_config.service /etc/systemd/system/update_config.service
chmod 0644 /etc/systemd/system/update_config.service

systemctl enable update_config
```