FROM brimstone/debian:sid as discord  
  
RUN package build-essential git autoconf gettext libtool bitlbee-dev \  
pkg-config libglib2.0-dev  
  
RUN git clone https://github.com/sm00th/bitlbee-discord /discord  
  
WORKDIR /discord  
  
RUN ./autogen.sh  
  
RUN ./configure  
  
RUN make install  
  
RUN find /usr -iname '*discord*' -ls  
  
FROM brimstone/debian:sid  
  
ENTRYPOINT ["/loader"]  
  
EXPOSE 22  
# Install needed packages  
RUN package weechat-curses vim rsync libwww-perl \  
ssh tmux zsh sudo cron libtext-charwidth-perl less git psmisc \  
python-potr bitlbee \  
curl python-websocket runit locales \  
&& rm /etc/ssh/ssh_host_* \  
&& sed '/%sudo/s/^.*$/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/' -i /etc/sudoers \  
&& sed '/pam_loginuid.so/s/^/#/g' -i /etc/pam.d/* \  
&& echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \  
&& echo "LANG=\"en_US.UTF-8\"" > /etc/default/locale \  
&& /usr/sbin/locale-gen en_US.UTF-8  
  
COPY \--from=discord /usr/lib/bitlbee/discord.* /usr/lib/bitlbee/  
  
COPY init /init  
  
COPY service /service  
  
COPY loader loader  
  
ENV TERM screen-256color  
  
ENV LANG en_US.UTF-8  

