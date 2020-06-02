FROM alpine:edge

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
ENV DEBUG=false

ADD https://git.archlinux.org/svntogit/packages.git/plain/trunk/xvfb-run?h=packages/xorg-server /usr/bin

RUN chmod +x /usr/bin/xvfb-run && \
    chmod 775 /usr/bin/xvfb-run && \
    cat /etc/apk/repositories  | tail -n 1 | sed 's/edge.*/edge\/testing/g' | tee -a /etc/apk/repositories && \
    apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache \
      bash \
      coreutils \
      sudo \
      parallel \
      xvfb \
      x11vnc \
      xterm \
      dbus \
      python \
      nodejs \
      nodejs-npm \
      firefox-esr \
      adwaita-gtk2-theme \
      adwaita-icon-theme \
      ttf-liberation \
      openbox && \
    npm install -g casperjs@1.1.2 && \
    npm install -g slimerjs && \
    yes | adduser testuser -s /bin/bash -h /home/testuser && \
    chown -R testuser:testuser /home/testuser && \
    mkdir -p /tmp/.X11-unix && \
    sudo chmod 1777 /tmp/.X11-unix && \
    sudo chown root /tmp/.X11-unix/

USER testuser

CMD echo "A VNC server will be started at $(ip addr show eth0 | grep inet | awk '{print $2}' | sed 's/\/.*//g'):5900"; \
    echo "You can point any VNC client at that address to troubleshoot any tests that hang"; \
    xvfb-run --server-args "-screen 0 1920x1080x24" xterm -e "sh -c 'x11vnc -bg -forever & openbox & set -e;env;find . -name \"*.js\" | SHELL=$SHELL parallel --no-notice -x --delay 0.25 --halt now,fail=1 casperjs test {} --debug=$DEBUG $VERBOSE --log-level=$LOGLEVEL $FAILFAST --engine=$ENGINE --username=$USERNAME --password=$PASSWORD --token=$TOKEN --url=$URL --font-linux=$FONTLINUX | tee -a /tmp/test.log;'" & tail -F /tmp/test.log --pid=$!; if grep -q FAIL /tmp/test.log; then exit 1; else exit 0; fi
