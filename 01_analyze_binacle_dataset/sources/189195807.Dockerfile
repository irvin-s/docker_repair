#BUILD_PUSH=hub,quay
FROM bigm/base-jdk8

#= openfire
ENV OPENFIRE_VERSION 3.9.3
RUN /xt/tools/_apt_install adduser \
    && /xt/tools/_download /tmp/openfire_${OPENFIRE_VERSION}_all.deb http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}_all.deb \
    && dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
    && rm -rf /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
    && chown -R root:root /usr/share/openfire /etc/openfire /var/lib/openfire /etc/openfire /var/log/openfire \
    && /xt/tools/_apt_remove adduser
#= .openfire

# project files
ADD ./prj /prj

# configure
# see https://community.igniterealtime.org/thread/48304
EXPOSE 5222 5223 5224 7777
#EXPOSE 5229 7070 7443 9090 9091
#EXPOSE 3478 3479 # stun

#VOLUME ["/prj/data/openfire"]

# TODO use base-deb supervisor mechanism
ENV OPENFIRE_XMX 250m
CMD ["/prj/bin/run_openfire"]
