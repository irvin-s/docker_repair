FROM bigm/base-deb

# apt-cacher-ng
RUN /xt/tools/_apt_install apt-cacher-ng \
    && /xt/tools/_enable_cron
#RUN sed 's/# ForeGround: 0/ForeGround: 1/' -i /etc/apt-cacher-ng/acng.conf
ADD supervisor/apt-cacher-ng.conf /etc/supervisord.d/apt-cacher-ng.conf
EXPOSE 3142
VOLUME ["/var/cache/apt-cacher-ng"]
# .apt-cacher-ng

# squid3
RUN /xt/tools/_apt_install squid3
ADD squid.conf /etc/squid3/squid.conf
ADD startup/squid3 /prj/startup/squid3
ADD supervisor/squid.conf /etc/supervisord.d/squid.conf
EXPOSE 3128
VOLUME ["/var/spool/squid3", "/etc/squid3/conf.d"]
# .squid3


# TODO docker-registry
# .docker-registry
