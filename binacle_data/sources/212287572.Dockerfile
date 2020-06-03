FROM alpine:3.4
MAINTAINER Xan Nick "xan.nick@gmail.com"
# NOTE: Using alpine:edge due to Samba regression
# for guest access effecting Mac OS X clients

# Install software and add share folder
RUN apk --update add \
  bash \
  iptables \
  docker \
  samba \
  && rm -rf /var/cache/apk/* \
  && mkdir /containers

# Add Samba config and settings
ADD smb.conf /etc/samba/smb.conf

# Add script for symlinking containers
ADD share.sh /bin/share

# Add Entrypoint to start Samba
ENTRYPOINT /usr/sbin/smbd -FS < /dev/null
