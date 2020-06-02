# docker file used as a base image
FROM  node:8.11

RUN apt-get update \
  && apt-get install -y g++-4.8 g++-4.8-multilib gcc-multilib libgtk2.0-0 libxtst6 libnotify4 libgconf2-4 socat libusb-1.0-0-dev libudev-dev lsof

# needed to run headless chrome
RUN apt-get install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0  libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils

# aws cli
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py
RUN apt-get install -y python-dev
RUN pip install awscli

WORKDIR /app
