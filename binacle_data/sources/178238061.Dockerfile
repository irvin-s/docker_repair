# Just a quick hack of kdelfour/lychee-docker for my own needs
FROM kdelfour/lychee-docker
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

RUN sed -i "s/33/1000/g" /etc/passwd
RUN sed -i "s/33/1000/g" /etc/group
