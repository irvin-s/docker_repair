# Stringer - an awesome Google Reader alternative in a Docker sandbox
#
# based on Docker base image with Ruby 1.9.3 from Debian/Ubuntu and Postgresql
#
# MAINTAINER  Luigi Maselli
# VERSION        0.4
# DOCKER-VERSION 0.3.4
#
# WARNING: I don't know if it really a docker file but it helped me to build the image
#
## If you want to try directly the built image
# $ docker pull grigio/stringer-reader
# $ docker run -p 5000 -t -i grigio/stringer-reader /bin/bash
# $ docker ps (in another terminal)
# .. and get the mapped docker port in the host ex: localhost:49169


FROM  base

# copy deploy.sh in the container
# in bin
ADD deploy.sh /bin/deploy.sh
RUN chmod +x /bin/deploy.sh

RUN deploy.sh system_setup

RUN deploy.sh app_setup


EXPOSE 5000
CMD    ["/bin/deploy.sh", "app_run"]
