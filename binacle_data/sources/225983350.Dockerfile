FROM kalilinux/kali-linux-docker
MAINTAINER apolloclark@gmail.com

# configure apt-get
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list

# upgrade Kali, install the kali-linux-top10
RUN apt-get -y update && \
    apt-get -y dist-upgrade && \
    apt-get clean
RUN apt-get -y install kali-linux-web

CMD ["/bin/bash"]
