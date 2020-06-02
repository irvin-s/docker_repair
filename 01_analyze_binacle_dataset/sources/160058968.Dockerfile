FROM ubuntu:10.04
MAINTAINER Juan Luis Baptiste juan.baptiste@gmail.com
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get install -y language-pack-en vim wget
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales

# Add the BigBlueButton key
RUN wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | apt-key add -

# Add the BigBlueButton repository URL and ensure the multiverse is enabled
RUN echo "deb http://ubuntu.bigbluebutton.org/lucid_dev_081/ bigbluebutton-lucid main" | tee /etc/apt/sources.list.d/bigbluebutton.list

#Add multiverse repo
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ lucid multiverse" | tee -a /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y dist-upgrade

#Install LibreOffice
RUN wget http://bigbluebutton.googlecode.com/files/openoffice.org_1.0.4_all.deb
RUN dpkg -i openoffice.org_1.0.4_all.deb
RUN apt-get install -y python-software-properties
RUN apt-add-repository ppa:libreoffice/libreoffice-4-0
RUN apt-get -y update
RUN apt-get install -y --allow-unauthenticated libreoffice-common libreoffice

#Install required Ruby version
RUN apt-get install -y libffi5 libreadline5 libyaml-0-2 libgdbm3
RUN wget https://bigbluebutton.googlecode.com/files/ruby1.9.2_1.9.2-p290-1_amd64.deb
RUN dpkg -i ruby1.9.2_1.9.2-p290-1_amd64.deb
RUN update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.2 500 \
                         --slave /usr/bin/ri ri /usr/bin/ri1.9.2 \
                         --slave /usr/bin/irb irb /usr/bin/irb1.9.2 \
                         --slave /usr/bin/erb erb /usr/bin/erb1.9.2 \
                         --slave /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.2
RUN update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.2 500

#Install ffmpeg
RUN apt-get install -y build-essential git-core checkinstall yasm texi2html libvorbis-dev libx11-dev libxfixes-dev zlib1g-dev pkg-config
ADD deb/ffmpeg_5:2.0.1-1_amd64.deb /tmp/
RUN dpkg -i /tmp/ffmpeg_5:2.0.1-1_amd64.deb
RUN rm -f /tmp/*.deb

#Install Tomcat prior to bbb installation
RUN apt-get install -y tomcat6

#Replace init script, installed one is broken
ADD scripts/tomcat6 /etc/init.d/

#Install BigBlueButton
RUN apt-get -y update
RUN export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8 && gem install bundler -v 1.10.6
RUN gem install archive-tar-minitar 
RUN gem install hoe -v 2.8.0
RUN gem install rcov -v 0.9.11
RUN su - -c "apt-get install -y bigbluebutton" 

EXPOSE 80 9123 1935

#Add helper script to start bbb
ADD scripts/bbb-start.sh /usr/bin/

CMD ["/usr/bin/bbb-start.sh"]
