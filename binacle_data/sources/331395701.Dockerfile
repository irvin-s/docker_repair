FROM ubuntu:16.04
LABEL maintainer "matheus.arendt.hunsche@gmail.com"
RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install \
    curl \
    unzip \
    build-essential \
    zlib1g-dev \
    libcurl3 \
    libcurl4-gnutls-dev \
    xterm \
    libpq5 \
    libmongoc-1.0-0 \
    && ln -s /usr/lib/x86_64-linux-gnu/libpq.so.5 /usr/lib/x86_64-linux-gnu/libpq.so \
    && ln -s /usr/lib/x86_64-linux-gnu/libmongoc-1.0.so.0 /usr/lib/x86_64-linux-gnu/libmongoc-1.0.so \
    && ln -s /usr/lib/x86_64-linux-gnu/libbson-1.0.so.0 /usr/lib/x86_64-linux-gnu/libbson-1.0.so \
    && apt-get -y autoremove \
    && apt-get -y autoclean
ADD . /tmp
RUN cd tmp \
    && curl -L \
    https://github.com/golang-migrate/migrate/releases/download/v3.4.0/migrate.linux-amd64.tar.gz > \
    /tmp/migrate.tar.gz \
    && tar -xzvf migrate.tar.gz \
    && mv migrate.linux-amd64 /usr/bin/migrate \
    && curl -L http://altd.embarcadero.com/download/interbase/2017/latest/InterBase_2017_EN.zip > \
    interbase.zip \
    && unzip interbase.zip \
    && chmod +x ib_install_linux_x86_64.bin \
    && ./ib_install_linux_x86_64.bin -i silent -r /tmp/output || true \
    && cat output \
    && tar -xzvf paserver.tar.gz \
    && mv PAServer-19.0 /root/PAServer \
    && ln -s /root/PAServer/paserver /usr/bin/paserver \
    && tar -xzvf emsserver.tar.gz \
    && cd emsserver \ 
    && ./ems_install.sh \
    && ln -s /usr/lib/ems/EMSDevConsoleCommand /usr/bin/ems-console \
    && curl -L \
    https://github.com/maxcnunes/waitforit/releases/download/v2.2.0/waitforit-linux_amd64 > \
    /usr/bin/waitforit \
    && chmod +x /usr/bin/waitforit \
    && mv /tmp/start.sh ~/ \
    && sed -i -e 's/\r$//' ~/start.sh \
    && chmod +x ~/start.sh \
    && ln -s ~/start.sh /usr/bin/start \
    && rm -rf /tmp/*
WORKDIR ~/
EXPOSE 64211
ENV RAD_SERVER_RESOURCES_FILES=/etc/ems/objrepos/
ENV RAD_SERVER_CONSOLE_PORT=8081
ENV RAD_SERVER_CONSOLE_PASS=consolepass
ENV RAD_SERVER_CONSOLE_USER=consoleuser
ENV RAD_SERVER_SERVER_PORT=8080
ENV RAD_SERVER_DB_USERNAME=sysdba
ENV RAD_SERVER_DB_PASSWORD=masterkey
CMD ["start"]
