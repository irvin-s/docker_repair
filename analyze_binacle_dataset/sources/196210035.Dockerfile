FROM pritunl/archlinux
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
RUN pacman -Sy

RUN pacman -S --noconfirm base-devel
RUN pacman -S --noconfirm pulseaudio pulseaudio-alsa alsa-utils
RUN pacman -S --noconfirm libx11 ttf-dejavu ttf-freefont ttf-ubuntu-font-family
RUN pacman -S --noconfirm wget git unzip jq nano

ADD aurget.sh /usr/local/bin/aurget
RUN chmod +x /usr/local/bin/aurget

ADD aurmake.sh /usr/local/bin/aurmake
RUN chmod +x /usr/local/bin/aurmake

ADD appinit.sh /usr/local/bin/appinit
RUN chmod +x /usr/local/bin/appinit

ADD appinitpanel.sh /usr/local/bin/appinitpanel
RUN chmod +x /usr/local/bin/appinitpanel

ADD getsetting.sh /usr/local/bin/getsetting
RUN chmod +x /usr/local/bin/getsetting

RUN useradd -m -g users -s /bin/bash docker
RUN echo "cookie-file = /tmp/.pulse-cookie" >> /etc/pulse/client.conf

RUN sudo -u docker mkdir -p /home/docker/.config/fontconfig
RUN sudo -u docker mkdir -p /home/docker/.config/gtk-3.0
RUN sudo -u docker mkdir -p /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml
ADD fonts.conf /home/docker/.config/fontconfig
ADD gtk2.conf /home/docker/.gtkrc-2.0
ADD gtk3.conf /home/docker/.config/gtk-3.0/settings.ini
ADD xfce4-desktop.xml /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
ADD xfce4-panel.xml /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
ADD xfwm4.xml /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
ADD xsettings.xml /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
RUN chown docker:users /home/docker/.config/fontconfig
RUN chown docker:users /home/docker/.gtkrc-2.0
RUN chown docker:users /home/docker/.config/gtk-3.0/settings.ini
RUN chown docker:users /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
RUN chown docker:users /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
RUN chown docker:users /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
RUN chown docker:users /home/docker/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

RUN echo 'MAKEFLAGS="-j8"' >> /etc/makepkg.conf
