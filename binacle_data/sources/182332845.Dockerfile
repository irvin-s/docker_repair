FROM phusion/baseimage:0.9.15

MAINTAINER Flip Kromer <flip@infochimps.com>, Russell Jurney

WORKDIR /root
ENV HOME /root

ENV safe_apt_install apt-get install -y --no-install-recommends

EXPOSE 22

# Using the `code/` directory in the big_data_for_chimps git repo as working directory:
#
#   Build  image     with `docker build -t ubuntu-bd4c config/ubuntu-bd4c/`
#   Test   container with `docker run --name u_bd4c_scratch -i -t ubuntu-bd4c`
#   Delete container with `docker rm    u_bd4c_scratch`

# ---------------------------------------------------------------------------
#
# Initial Tasks
#

# Figure out the IP address of docker host
#
RUN                                                               \
  apt-get update &&                                               \
  route -n | awk '/^0.0.0.0/ {print $2}' > /etc/docker_host_ip && \
  echo "************ Docker Host: " && cat /etc/docker_host_ip

#
# NOTE: INSECURE THING IS INSECURE
#
RUN /usr/sbin/enable_insecure_key && /etc/my_init.d/00_regen_ssh_host_keys.sh

# # Use the deb-proxy cache started in helper
# COPY /img/baseimage/setup-deb_proxy.sh     /build/
# RUN          /build/setup-deb_proxy.sh

# Add the apt repos and a few preliminary tools we will use (40 MB)
#
COPY /img/baseimage/setup-add_apt_repos.sh /build/
RUN          /build/setup-add_apt_repos.sh

# Install and configure Java -- 308 MB (!)
#
COPY /img/baseimage/setup-java.sh          /build/
RUN          /build/setup-java.sh
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV PATH      $PATH:$JAVA_HOME/bin

# Install some developer conveniences
#
# * utils       -- 71MB
# * build tools -- 96 MB
# * libs        -- 25 MB
# * python      -- 80 MB
# * emacs       -- 80 MB
# * node        -- 8 MB
# * ruby        -- 27 MB
#
COPY /img/baseimage/setup-add_conveniences.sh /build/
RUN          /build/setup-add_conveniences.sh

# Finish configuration
#
# * Install templating tool
# * Enable SSH service
#
COPY /img/baseimage/setup-other_configuration.sh /build/
RUN          /build/setup-other_configuration.sh

CMD ["/sbin/my_init"]
