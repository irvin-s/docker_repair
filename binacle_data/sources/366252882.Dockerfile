FROM resin/%%RESIN_MACHINE_NAME%%-node:4.0.0
MAINTAINER Craig Mulligan <craig@resin.io>
ENV INITSYSTEM on

ENV DEBIAN_FRONTEND noninteractive

# native deps for electron
RUN apt-get update && apt-get install -yq --no-install-recommends \
    xserver-xorg-core \
    xorg \
    libgtk2.0-0 \
    libnotify4 \
    libgconf2-4 \
    libnss3 \
    libasound2 \
    matchbox && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /usr/src/app && ln -s /usr/src/app /app
COPY package.json /usr/src/app/package.json
WORKDIR /usr/src/app
RUN JOBS=MAX npm install --unsafe-perm

COPY . /usr/src/app

CMD ["xinit", "/usr/src/app/launch_app.sh", "--kiosk", "--", "-nocursor"]
