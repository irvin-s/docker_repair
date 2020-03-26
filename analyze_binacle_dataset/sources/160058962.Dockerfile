FROM ubuntu:14.04
MAINTAINER Juan Luis Baptiste juan.baptiste@gmail.com
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

RUN echo -n  INITRD=no > /etc/environment
RUN mkdir -p /etc/container_environment
RUN echo -n no > /etc/container_environment/INITRD
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
RUN dpkg-divert --local --rename --add /usr/bin/ischroot
RUN ln -sf /bin/true /usr/bin/ischroot
RUN apt-get install -y language-pack-en vim wget

#Add multiverse repo
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse" | tee -a /etc/apt/sources.list
# Add the BigBlueButton key
RUN wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | apt-key add -
# Add the BigBlueButton repository URL and ensure the multiverse is enabled
RUN echo "deb http://ubuntu.bigbluebutton.org/trusty-090/ bigbluebutton-trusty main" | tee /etc/apt/sources.list.d/bigbluebutton.list
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:libreoffice/libreoffice-4-4

#Install ffmpeg
#RUN apt-get install -y build-essential git-core checkinstall yasm texi2html libvorbis-dev libx11-dev libxfixes-dev zlib1g-dev pkg-config
RUN apt-get install -y libvpx1 libvorbisenc2
ADD deb/ffmpeg_2.3.3-1_amd64.deb .
RUN dpkg -i ffmpeg_2.3.3-1_amd64.deb

RUN bash -c "echo -e '#!/bin/bash\nexit 101' | install -m 755 /dev/stdin /usr/sbin/policy-rc.d"
#Install BigBlueButton
# #RUN apt-get update -y
#RUN apt-get install -y bigbluebutton
RUN apt-get install -y acl at-spi2-core authbind binutils build-essential ca-certificates-java cabextract \
  colord comerr-dev cpp cpp-4.8 dbus dbus-x11 dconf-gsettings-backend \
  dconf-service default-jre default-jre-headless desktop-file-utils \
  dictionaries-common dosfstools dpkg-dev esound-common fakeroot fontconfig \
  fontconfig-config fonts-crosextra-caladea fonts-crosextra-carlito \
  fonts-dejavu fonts-dejavu-core fonts-dejavu-extra fonts-liberation \
  fonts-opensymbol fonts-sil-gentium fonts-sil-gentium-basic fuse g++ g++-4.8 \
  gcc gcc-4.8 gconf-service gconf-service-backend gconf2 gconf2-common gdisk \
  geoip-database ghostscript git git-man groff-base gsfonts gvfs gvfs-common \
  gvfs-daemons gvfs-libs hicolor-icon-theme hunspell-en-us imagemagick \
  imagemagick-common java-common jsvc krb5-multidev libaa1 libaacs0 \
  libalgorithm-diff-perl libalgorithm-diff-xs-perl libalgorithm-merge-perl \
  libao-common libao4 libapparmor1 libasan0 libasound2 libasound2-data \
  libasyncns0 libatasmart4 libatk-bridge2.0-0 libatk-wrapper-java \
  libatk-wrapper-java-jni libatk1.0-0 libatk1.0-data libatomic1 libatspi2.0-0 \
  libaudiofile1 libavahi-client3 libavahi-common-data libavahi-common3 \
  libavahi-glib1 libavcodec54 libavformat54 libavutil52 libbluray1 \
  libbonobo2-0 libbonobo2-common libboost-date-time1.54.0 \
  libboost-system1.54.0 libc-dev-bin libc6-dev libcaca0 libcairo-gobject2 \
  libcairo2 libcanberra0 libcdparanoia0 libcdr-0.0-0 libcloog-isl4 \
  libclucene-contribs1 libclucene-core1 libcmis-0.4-4 libcolamd2.8.0 \
  libcolord1 libcolorhug1 libcommons-collections3-java libcommons-daemon-java \
  libcommons-dbcp-java libcommons-pool-java libcroco3 libcups2 libcupsfilters1 \
  libcupsimage2 libcurl3 libcurl4-openssl-dev libdatrie1 libdca0 libdconf1 \
  libdirectfb-1.2-9 libdjvulibre-text libdjvulibre21 libdpkg-perl \
  libdrm-intel1 libdrm-nouveau2 libdrm-radeon1 libdvdnav4 libdvdread4 \
  libecj-java libedit2 libelf1 libenca0 liberror-perl libesd0 libexif12 \
  libexttextcat-2.0-0 libexttextcat-data libfaad2 libfakeroot libfftw3-double3 \
  libfile-fcntllock-perl libflac8 libfontconfig1 libfontenc1 libfreetype6 \
  libfuse2 libgcc-4.8-dev libgconf-2-4 libgconf2-4 libgcrypt11-dev libgd3 \
  libgdk-pixbuf2.0-0 libgdk-pixbuf2.0-common libgeoip1 \
  libgeronimo-jta-1.1-spec-java libgif4 libgl1-mesa-dri libgl1-mesa-glx \
  libglapi-mesa libglu1-mesa libgmp10 libgnome2-0 libgnome2-bin \
  libgnome2-common libgnomevfs2-0 libgnomevfs2-common libgnutls-dev \
  libgnutlsxx27 libgomp1 libgpg-error-dev libgphoto2-6 libgphoto2-l10n \
  libgphoto2-port10 libgraphite2-3 libgs9 libgs9-common libgsm1 libgssrpc4 \
  libgstreamer-plugins-base1.0-0 libgstreamer1.0-0 libgtk-3-0 libgtk-3-bin \
  libgtk-3-common libgtk2.0-0 libgtk2.0-bin libgtk2.0-common libgudev-1.0-0 \
  libgusb2 libharfbuzz-icu0 libharfbuzz0b libhsqldb1.8.0-java \
  libhunspell-1.3-0 libhyphen0 libice6 libicu52 libidl-common libidl0 \
  libidn11-dev libieee1284-3 libijs-0.35 libilmbase6 libisl10 libitm1 \
  libjack-jackd2-0 libjasper1 libjbig0 libjbig2dec0 libjemalloc1 \
  libjpeg-turbo8 libjpeg8 libkadm5clnt-mit9 libkadm5srv-mit9 libkdb5-7 \
  libkrb5-dev liblangtag-common liblangtag1 liblcms2-2 libldap2-dev \
  liblircclient0 libllvm3.4 liblqr-1-0 libltdl7 liblzo2-2 libmagickcore5 \
  libmagickcore5-extra libmagickwand5 libmhash2 libmp3lame0 libmpc3 libmpeg2-4 \
  libmpfr4 libmspub-0.0-0 libmythes-1.2-0 libncurses5-dev libneon27-gnutls \
  libnetpbm10 libnspr4 libnss3 libnss3-nssdb libodbc1 libopenal-data \
  libopenal1 libopencore-amrnb0 libopencore-amrwb0 libopenexr6 libopenjpeg2 \
  libopus0 liborbit-2-0 liborbit2 liborc-0.4-0 liborcus-0.6-0 libp11-kit-dev \
  libpam-systemd libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 \
  libpaper-utils libpaper1 libparted0debian1 libpciaccess0 libpcsclite1 \
  libpixman-1-0 libpolkit-agent-1-0 libpolkit-backend-1-0 \
  libpolkit-gobject-1-0 libpoppler44 libpostproc52 libpulse0 libpython-stdlib \
  libpython3.4 libquadmath0 libraptor2-0 librasqal3 librdf0 libreoffice \
  libreoffice-avmedia-backend-gstreamer libreoffice-base libreoffice-base-core \
  libreoffice-base-drivers libreoffice-calc libreoffice-common \
  libreoffice-core libreoffice-draw libreoffice-gnome libreoffice-gtk \
  libreoffice-impress libreoffice-java-common libreoffice-math \
  libreoffice-pdfimport libreoffice-report-builder-bin \
  libreoffice-sdbc-firebird libreoffice-sdbc-hsqldb libreoffice-style-galaxy \
  libreoffice-style-human libreoffice-writer librsvg2-2 librsvg2-common \
  librtmp-dev libruby1.9.1 libsamplerate0 libsane libsane-common \
  libschroedinger-1.0-0 libsdl1.2debian libsecret-1-0 libsecret-common \
  libservlet3.0-java libsm6 libsndfile1 libsox-fmt-alsa libsox-fmt-base \
  libsox2 libspeex1 libspeexdsp1 libssl-dev libssl-doc libstdc++-4.8-dev \
  libsvga1 libswscale2 libsystemd-daemon0 libsystemd-login0 libtasn1-6-dev \
  libtdb1 libthai-data libthai0 libtheora0 libtiff5 libtimedate-perl \
  libtinfo-dev libtomcat7-java libts-0.0-0 libtsan0 libtxc-dxtn-s2tc0 \
  libudisks2-0 libusb-1.0-0 libv4l-0 libv4lconvert0 libva1 libvdpau1 \
  libvisio-0.0-0 libvorbisfile3 libwavpack1 libwayland-client0 \
  libwayland-cursor0 libwmf0.2-7 libwpd-0.9-9 libwpg-0.2-2 libwps-0.2-2 \
  libwrap0 libx11-6 libx11-data libx11-xcb1 libx264-142 libx86-1 libxau6 \
  libxaw7 libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 \
  libxcb-render0 libxcb-shape0 libxcb-shm0 libxcb-sync1 libxcb1 libxcomposite1 \
  libxcursor1 libxdamage1 libxdmcp6 libxext6 libxfixes3 libxfont1 libxft2 \
  libxi6 libxinerama1 libxkbcommon0 libxml2-dev libxmu6 libxmuu1 libxpm4 \
  libxrandr2 libxrender1 libxshmfence1 libxslt1-dev libxslt1.1 libxt6 libxtst6 \
  libxv1 libxvidcore4 libxvmc1 libxxf86dga1 libxxf86vm1 libyajl2 libyaml-0-2 \
  linux-libc-dev lp-solve make manpages manpages-dev mencoder monit mplayer \
  netpbm nginx nginx-common nginx-core ntfs-3g odbcinst odbcinst1debian2 \
  openjdk-7-jre openjdk-7-jre-headless openssh-client parted patch pkg-config \
  policykit-1 policykit-1-gnome poppler-data poppler-utils psmisc python \
  python-apt python-chardet python-debian python-minimal python-six python2.7 \
  python2.7-minimal python3-uno redis-server redis-tools rsync ruby ruby1.9.1 \
  ruby1.9.1-dev sound-theme-freedesktop sox systemd-services systemd-shim tcpd \
  tomcat7 tomcat7-common tsconf ttf-mscorefonts-installer tzdata-java udisks2 \
  unixodbc uno-libs3 unzip update-notifier-common ure vorbis-tools x11-common \
  x11-utils xauth xfonts-encodings xfonts-mathml xfonts-utils zip zlib1g-dev

RUN apt-get install -y bbb-apps bbb-apps-deskshare bbb-apps-sip bbb-apps-video \
    bbb-client bbb-freeswitch bbb-red5 bbb-mkclean bbb-office bbb-playback-presentation \
    bbb-record-core  bbb-swftools
#Install a modified bbb-web package, the default postinst script tries to
#start tomcat, making the package installation fail thus breaking the install process.
ADD deb/bbb-web_0.9.0-1ubuntu66~jlb_all.deb .
RUN dpkg -i bbb-web_0.9.0-1ubuntu66~jlb_all.deb
RUN apt-get install -y bbb-config bbb-check haveged
#   bigbluebutton

RUN rm -fr /usr/sbin/policy-rc.d
#RUN bbb-conf --enablewebrtc

#EXPOSE 80 9123 1935 5060 5060/udp 5066 5066/udp 5080 5080/udp 16384-32768/udp
EXPOSE 80 9123 1935

#Add helper script to start bbb
ADD *.sh /
RUN chmod 755 /*.sh

CMD ["/bbb-start.sh"]
