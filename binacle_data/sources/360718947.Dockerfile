FROM debian:8.1
MAINTAINER sauercrowd
RUN apt-get update
RUN apt-get install -y curl
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install -y git make curl xorg nodejs build-essential python libgtk2.0-0  libgconf-2-4 libnss3 libasound2
WORKDIR /opt
RUN git clone https://github.com/zedtux/kitematic
WORKDIR /opt/kitematic/
RUN git checkout linux-support
RUN make
COPY entrypoint.sh /entrypoint.sh
RUN touch /root/.Xauthority
RUN chmod +x /entrypoint.sh
ENTRYPOINT bash /entrypoint.sh
