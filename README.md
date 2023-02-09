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

systemctl start update_config
systemctl enable update_config
```

check status

```bash
systemctl status update_config
```

check logs

```bash
tail -f /var/log/update_config.log
```

Sample logs:

```
09/02/2023 17:53:15 - config is up to date
09/02/2023 17:53:45 - running config update check
09/02/2023 17:53:45 - config is up to date
09/02/2023 17:54:15 - running config update check
09/02/2023 17:54:15 - config is up to date
09/02/2023 17:54:45 - running config update check
09/02/2023 17:54:45 - config is up to date
09/02/2023 17:55:15 - running config update check
09/02/2023 17:55:15 - config was updated  <=========
09/02/2023 17:55:15 - bio was restarted   <=========
09/02/2023 17:55:54 - running config update check
09/02/2023 17:55:54 - config is up to date
```

Other commands to debug:

```bash
# check bio
systemctl status bio

# check bio logs
journalctl -f
```