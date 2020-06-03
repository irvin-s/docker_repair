FROM hypriot/rpi-node:0.12.0

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    build-essential \
    ca-certificates \
    git \
    make \
    libgtk2.0-0 \
    libxtst6 \
    libnotify-bin \
    libgconf-2-4 \
    libnss3 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone -b linux-support https://github.com/zedtux/kitematic

WORKDIR /kitematic

RUN npm install boom

# electron 0.29 or higher is available for ARM
RUN sed -i 's/"electron-version": "0.27.2",/"electron-version": "0.29.0",/' package.json

RUN sed -i 's/"electron-prebuilt": "^0.27.3",/"electron-prebuilt": "^0.29.0",/' package.json

# show some RPi images
RUN sed -i 's,https://kitematic.com/recommended.json,http://blog.hypriot.com/recommended.json,' src/utils/RegHubUtil.js

# enable web preview between containers
RUN sed -i 's/var port = value\[0\].HostPort;/var port = dockerPort; ip = container.NetworkSettings.IPAddress;/' src/utils/ContainerUtil.js

RUN npm install hoek
RUN npm install is-property

RUN make

CMD ["npm", "start"]
