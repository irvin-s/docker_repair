FROM zuazo/chef-local:debian-7

COPY . /tmp/nethack
RUN berks vendor -b /tmp/nethack/Berksfile $COOKBOOK_PATH
RUN chef-client -r "recipe[apt],recipe[nethack]"

USER nethack
ENTRYPOINT ["/usr/games/nethack"]
