# python (gewo/python)
FROM gewo/interactive
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

RUN apt-get update
RUN apt-get -y install python python-dev python-setuptools && apt-get clean
RUN easy_install pip
CMD ["/bin/bash"]
