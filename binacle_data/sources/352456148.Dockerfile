FROM busybox
ADD built-check /opt/resource/check
ADD built-in /opt/resource/in

ADD assets/zoneinfo.zip /opt/resource/zoneinfo.zip
RUN mkdir -p /usr/share/zoneinfo && unzip /opt/resource/zoneinfo.zip -d /usr/share/zoneinfo
