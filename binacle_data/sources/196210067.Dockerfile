FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -Sdd --noconfirm ffmpeg gst-plugins-good
RUN pacman -S --noconfirm firefox

RUN aurget chromium-pepper-flash
RUN pacman -U --noconfirm /aur/chromium-pepper-flash*.pkg.tar

RUN aurget freshplayerplugin
RUN pacman -U --noconfirm /aur/freshplayerplugin*.pkg.tar

RUN rm -rf /aur

RUN sudo -u docker echo "enable_3d = 0" > /home/docker/.config/freshwrapper.conf

ADD init.sh .
CMD ["sh", "init.sh"]
