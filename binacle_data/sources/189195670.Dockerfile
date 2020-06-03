FROM bigm/base-deb-flat

# change to rebuild whole image
ENV XT_CACHE_REBUILD 4

# let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# set host apt_proxy on your DNS to point to bigm/proxy-cache instance
ENV XT_APT_PROXY "apt_proxy:3142 172.17.42.1:3142"

ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8

CMD ["/usr/local/bin/supervisord", "-c",  "/etc/supervisord.conf"]

# add our entrypoint
ENTRYPOINT ["/xt/tools/entrypoint.sh"]

ENV TERM xterm
ENV XT_PRJ_STARTUP /prj/startup
