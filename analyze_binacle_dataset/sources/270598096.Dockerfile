FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list) && \
    (echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list) && \
    (echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list) && \
    (echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list)

RUN  apt-get update && \
  apt-get install -y apt-transport-https && \
  apt-get install -y curl git unrar perl libnet-ssleay-perl && \
  apt-get -y -q install make build-essential libxml-sax-expat-perl
RUN (echo y;echo y)|cpan
RUN cpan File::Copy::Recursive File::Glob LWP::Simple TVDB::API Getopt::Long Switch WWW::TheMovieDB XML::Simple JSON::Parse

COPY tv_sort.sh /root/tv_sort.sh
COPY sorttv /root/sorttv
RUN chmod +x /root/tv_sort.sh


VOLUME ["/root/done"]
VOLUME ["/root/media"]
VOLUME ["/root/sort"]

CMD ["/bin/bash","/root/tv_sort.sh"]
