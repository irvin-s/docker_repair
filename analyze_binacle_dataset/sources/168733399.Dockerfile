FROM besn0847/ubuntu32
MAINTAINER Aleksey Krasnobaev <https://github.com/krasnobaev>

# building wine32

RUN apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget
RUN wget https://winezeug.googlecode.com/svn/trunk/install-wine-deps.sh --no-check-certificate; \
    sed -i -e 's/libhal-storage-dev-dev/libhal-storage-dev/' \
        -e 's/apt-get install /DEBIAN_FRONTEND=noninteractive apt-get install -y /g' install-wine-deps.sh
RUN source install-wine-deps.sh

COPY ./run.sh /usr/bin/
RUN chmod 755 /usr/bin/*.sh

WORKDIR /usr/src/wine32

CMD run.sh

