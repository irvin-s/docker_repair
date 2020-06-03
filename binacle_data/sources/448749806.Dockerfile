FROM phusion/baseimage:0.9.10
MAINTAINER mpeterson <docker@peterson.com.ar>

# Make APT non-interactive
ENV DEBIAN_FRONTEND noninteractive

# Ensure UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Change this ENV variable to skip the docker cache from this line on
ENV LATEST_CACHE 2014-05-01T22:00-03:00

# Upgrade the system to the latest version
RUN apt-get update
RUN apt-get upgrade -y

# Install packages needed for this image
RUN apt-get install -y --force-yes --no-install-recommends sslh

# This after the package installation so we can use the docker cache
RUN mkdir /build
ADD . /build

# Starting the installation of this particular image

EXPOSE 443
EXPOSE 22

# End of particularities of this image

# Give the possibility to override any file on the system
RUN cp -R /build/overrides/. / || :

# Add services
RUN cp -R /build/runit/. /etc/service/ || :

# Clean everything up
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build

CMD ["/sbin/my_init"]
