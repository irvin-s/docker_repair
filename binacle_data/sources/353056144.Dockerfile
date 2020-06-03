FROM centos:7

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael Soares (Tuelho) <rafaelcba@gmail.com>

RUN yum -y update; yum -y install hostname iproute unzip xterm net-tools nc openssh-server wget bsdtar; yum clean all

ENV TERM=xterm SOFTWARE_INSTALL_DIR=/opt/redhat

RUN mkdir -p $SOFTWARE_INSTALL_DIR

VOLUME /dnsmasq.hosts
RUN chmod -Rf a+w /dnsmasq.hosts/

COPY support/*.sh /

RUN . /build_setup.sh

CMD ["/bin/cat", "/etc/redhat-release"]

###################
# IMPORTANT NOTE!!!
###################
# from Dockerfile reference manual...
# https://docs.docker.com/reference/builder/
# https://docs.docker.com/articles/dockerfile_best-practices/
#
# The best use for ENTRYPOINT is to set the image’s main command, 
# allowing that image to be run as though it was that command (and then use CMD as the default flags).

# Command line arguments to docker run <image> will be appended after all elements 
# in an exec form ENTRYPOINT, and will override all elements specified using CMD. 
# This allows arguments to be passed to the entry point, i.e., 
# docker run <image> -d will pass the -d argument to the entry point. 
# You can override the ENTRYPOINT instruction using the docker run --entrypoint flag.
#
# The shell form prevents any CMD or run command line arguments from being used, 
# but has the disadvantage that your ENTRYPOINT will be started as a subcommand of /bin/sh -c, 
# which does not pass signals. 
# This means that the executable will not be the container’s PID 1 - and will not receive Unix signals - 
# so your executable will not receive a SIGTERM from docker stop <container>.
#
# Only the last ENTRYPOINT instruction in the Dockerfile will have an effect.
#
# On derived executable images (services) always use:
#   ENTRYPOINT ["executable", "param1", "param2"] (the preferred exec form)
# in a combination with ENTRYPOINT you can use the CMD to pass default exec command's arguments to the ENTRYPOINT.
# 
# Command line arguments to docker run <image> will be appended after all elements in an exec form ENTRYPOINT, 
# and will override all elements specified using CMD. 
# This allows arguments to be passed to the entry point, i.e., 
# docker run <image> -d will pass the -d argument to the entry point. 
# You can override the ENTRYPOINT instruction using the docker run --entrypoint flag.
#
# To use ENTRYPOINT and CMD toguether your have to use the exec mode of ENTRYPOINT ["command", "argument"]. 
# I mean not in shel mode ["sh", "-c"]
# When creating a Dockerfile, make sure you use exec form of ENTRYPOINT or RUN commands. 
# Otherwise the application will be started as a subcommand of /bin/sh -c, which does not pass signals. 
# The container’s PID1 will be the shell, 
# your application will not receive any signals from the `docker kill` command.

