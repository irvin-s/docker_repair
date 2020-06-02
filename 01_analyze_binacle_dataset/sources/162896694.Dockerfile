FROM digitallyseamless/nodejs-bower-grunt
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update --fix-missing && \
    apt-get --no-install-recommends -y install \
    git build-essential vim xmlstarlet netcat libpng12-dev zlib1g-dev libexpat1-dev \
    byobu && \
    curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh &&\
    byobu-ctrl-a screen

RUN byobu-enable && \
    echo -n "" > /etc/motd && \
    mkdir -p /root/.byobu && \
    touch /root/.byobu/.welcome-displayed

ENTRYPOINT ["byobu"]
