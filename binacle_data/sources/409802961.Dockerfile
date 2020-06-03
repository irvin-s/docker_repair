FROM ubuntu:12.04

MAINTAINER cohesiveft
# This copyrighted material is the property of
# Cohesive Flexible Technologies and is subject to the license
# terms of the product it is contained within, whether in text
# or compiled form.  It is licensed under the terms expressed
# in the accompanying README.md and LICENSE.md files.
#
# This program is AS IS and  WITHOUT ANY WARRANTY; without even
# the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.

# make sure everything is up to date
RUN apt-get update

# install haproxy
RUN apt-get install -y haproxy

# move default config out of the way
RUN mv /etc/haproxy/haproxy.cfg /etc/haproxy/default_haproxy.cfg

# upload local haproxy config file
ADD ./haproxy.cfg /etc/haproxy/

# expose port 80
EXPOSE 80

# run haproxy
CMD /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg

# example usage:
# sudo docker run -d -p 80:80 cohesiveft/haproxy
