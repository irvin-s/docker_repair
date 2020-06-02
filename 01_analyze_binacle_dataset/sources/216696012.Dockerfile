FROM {{ image_spec("nova-base") }}
MAINTAINER {{ maintainer }}

RUN curl -L -o nova-novncproxy.tar.gz https://github.com/novnc/noVNC/archive/v{{ novnc_version }}.tar.gz && \
   tar -zxvf nova-novncproxy.tar.gz && \
   mv noVNC-{{ novnc_version }} /usr/share/novnc && \
   chown -R nova: /usr/share/novnc && \
   rm -f nova-novncproxy.tar.gz

USER nova
