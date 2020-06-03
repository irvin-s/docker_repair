#BUILD_PUSH=hub,quay
FROM bigm/base-deb-tools

# http://www.if-not-true-then-false.com/2011/nginx-and-php-fpm-configuration-and-optimizing-tips-and-tricks/
RUN /xt/tools/_apt_install make g++ xz-utils


#RUN /xt/tools/_ppa_install ppa:openssh-client
### mailing support
RUN apt-get update && apt-get install -y openssh-client \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/*

# install confd
ENV CONFD_VER 0.11.0
RUN /xt/tools/_download /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 \
	&& chmod  +x /usr/local/bin/confd

#install caddy
ENV CADDY_VER 0.9.4
RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://github.com/mholt/caddy/releases/download/v${CADDY_VER}/caddy_linux_amd64.tar.gz" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy_linux_amd64 \
 && mv /usr/bin/caddy_linux_amd64 /usr/bin/caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version
 
# TODO update cond creation 
# add caddy templates
ADD root/ /
# folders under /xt/defaults will be populated in instance if they are empty
RUN mkdir -p /xt/defaults/etc \
    && cp -rp /etc/confd /xt/defaults/etc/confd
 
# final
ADD supervisor.d/* /etc/supervisord.d/
ADD startup/* /prj/startup/

EXPOSE 80 443 2015
RUN mkdir -p /root/.caddy #certificates are stored here to avoind ban for overuse
RUN mkdir -p /root/logs # probably wrong palce but want to to keep it all together

#CMD ["/usr/bin/caddy", "--conf", "/etc/Caddyfile", "--log", "stdout"]