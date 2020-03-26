FROM debian:stretch

ARG NODESOURCE=https://deb.nodesource.com/setup_8.x
ARG FIREFOX=https://download-installer.cdn.mozilla.net/pub/firefox/releases/52.2.1esr/linux-x86_64/en-US/firefox-52.2.1esr.tar.bz2

ENV SHELL=/bin/bash
ENV WAIT=0
ENV VERBOSE=--verbose
ENV LOGLEVEL=info
ENV FAILFAST=--fail-fast
ENV ENGINE=slimerjs
ENV USERNAME=admin
ENV PASSWORD=admin
ENV TOKEN=1234567890ABCDEFGHJKLMNOP
ARG URL=http://127.0.0.1:3003
ENV URL=$URL
ENV FONTLINUX=fl-alpine

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && \
    apt-get install -y \
      sudo \
      bzip2 \
      parallel \
      xvfb \
      curl \
      gnupg \
      python \
      $(apt-cache depends firefox-esr | awk '/Depends:/{print$2}') \
      xorg \
      xvfb \
      x11vnc \
      openbox \
      dbus-x11 \
      xfonts-100dpi \
      xfonts-75dpi \
      xfonts-cyrillic \
      fonts-liberation && \
    curl -sL $NODESOURCE | sudo -E bash - && \
    apt-get update && \
    apt-get install -y nodejs phantomjs && \
    npm install -g casperjs@1.1.2 && \
    npm install -g slimerjs && \
    cd /tmp && \
    curl -s -L -O $FIREFOX && \
    tar -xvjf firefox-*.tar.bz2 -C /opt && \
    ln -fs /opt/firefox/firefox /usr/bin/firefox && \
    useradd testuser && \
    mkdir -p /home/testuser && \
    chown -R testuser:testuser /home/testuser/ && \
    mkdir -p /tmp/.X11-unix && \
    sudo chmod 1777 /tmp/.X11-unix && \
    sudo chown root /tmp/.X11-unix/

USER testuser

CMD echo "A VNC server will be started at $(ip addr show eth0 | grep inet | awk '{print $2}' | sed 's/\/.*//g'):5900"; \
    echo "You can point any VNC client at that address to troubleshoot any tests that hang"; \
    xvfb-run --server-args "-screen 0 1920x1080x24" xterm -e "sh -c 'x11vnc -bg -forever & openbox & set -e;env;find . -name \"*.js\" | SHELL=$SHELL parallel --no-notice -x --delay 0.25 --halt now,fail=1 casperjs test {} --debug=$DEBUG $VERBOSE --log-level=$LOGLEVEL $FAILFAST --engine=$ENGINE --username=$USERNAME --password=$PASSWORD --token=$TOKEN --url=$URL --font-linux=$FONTLINUX | tee -a /tmp/test.log;'" & tail -F /tmp/test.log --pid=$!; if grep -q FAIL /tmp/test.log; then exit 1; else exit 0; fi
