FROM ubuntu

# installs Dockito Vault ONVAULT utility
# https://github.com/dockito/vault
RUN apt-get update -y && \
      apt-get install -y curl && \
      curl -L $(ip route|awk '/default/{print $3}'):14242/ONVAULT > /usr/local/bin/ONVAULT && \
      chmod +x /usr/local/bin/ONVAULT

ENV REV_BREAK_CACHE=1
RUN ONVAULT echo 'ENV:' && env && echo 'TOKEN ENV' && echo $TOKEN
RUN ONVAULT ls -lha ~/.ssh/
