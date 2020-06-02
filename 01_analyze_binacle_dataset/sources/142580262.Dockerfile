#
# ecDock install container
#
# to build: sudo docker build -t ecdock/install .

FROM ubuntu
MAINTAINER ecDock team <jvb127@gmail.com>

# You may need to set these
# ENV http_proxy http://my.proxy.org
# ENV https_proxy http://my.proxy.org

RUN apt-get update && apt-get install -y wget dialog ssh 
ADD ecDock.tar.gz /install/
ADD install_ecDock.sh /

ENTRYPOINT ["/install_ecDock.sh"]
