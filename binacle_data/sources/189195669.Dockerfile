#BUILD_METHOD=single
#BUILD_PUSH=hub,quay
#BUILD_PUSH_TAG_FROM=XT_CACHE_REBUILD
FROM bigm/base-deb-minimal:latest

# change to rebuild whole image
ENV XT_CACHE_REBUILD 4

# let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Keep upstart from complaining
# see https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl \
    && ln -sf /bin/true /sbin/initctl

# Replace the 'ischroot' tool to make it always return true.
# Prevent initscripts updates from breaking /dev/shm.
RUN dpkg-divert --local --rename --add /usr/bin/ischroot \
    && ln -sf /bin/true /usr/bin/ischroot

# copy tool scripts needed in this Dockerfile
COPY tools/_apt_install /xt/tools/_apt_install

# cached apt-get
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN /xt/tools/_apt_install netcat socat apt-utils net-tools iputils-ping
# http://askubuntu.com/questions/53443/how-do-i-ignore-a-proxy-if-not-available
# docker run --name="apt-cache" -d -p 3142:3142 -v /var/cache/apt:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest
ADD shared/detect-http-proxy /etc/apt/detect-http-proxy
ADD shared/30detectproxy etc/apt/apt.conf.d/30detectproxy
# set host apt_proxy on your DNS to point to bigm/proxy-cache instance
ENV XT_APT_PROXY "apt_proxy:3142 172.17.42.1:3142"

# set locale to UTF-8
#ENV LANG C.UTF-8
RUN /xt/tools/_apt_install locales
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales \
    && echo "LC_ALL=en_US.UTF-8" > /etc/default/locale \
    && echo "LANG=en_US.UTF-8" >> /etc/default/locale

# upgrade Ubuntu
RUN apt-get update \
    && apt-get -yqq --no-install-recommends dist-upgrade \
    && rm -rf /var/lib/apt/lists/*

# make supervisor available
RUN /xt/tools/_apt_install python-setuptools inotify-tools \
    && /usr/bin/easy_install supervisor supervisor-stdout \
    && mkdir -p /etc/supervisord.d \
    && mkdir -p /var/log/supervisor
ADD shared/supervisord.conf /etc/supervisord.conf
ADD shared/onstart.conf /etc/supervisord.d/onstart.conf
CMD ["/usr/local/bin/supervisord", "-c",  "/etc/supervisord.conf"]

# install all /xt/tools
RUN /xt/tools/_apt_install curl ca-certificates libssl1.0.0
COPY tools /xt/tools

# add our entrypoint
ENTRYPOINT ["/xt/tools/entrypoint.sh"]

# add non-root user
RUN useradd -u 500 core
ENV TERM xterm
ENV XT_PRJ_STARTUP /prj/startup

# in INHERITED images add commands to be executed on docker start with:
#ADD startup/* /xt/startup/
# in INHERITED images configure supervisor with:
#ADD supervisor/* /etc/supervisord.d/

