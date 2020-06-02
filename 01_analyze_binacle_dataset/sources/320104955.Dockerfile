FROM telegraf:1.6

ADD ./telegraf.toml /etc/telegraf/telegraf.conf
