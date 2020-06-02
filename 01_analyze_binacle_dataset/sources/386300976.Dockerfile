FROM ubuntu:14.04
MAINTAINER goranche

ADD tmp_install.sh /opt/install.sh
RUN /bin/bash /opt/install.sh

EXPOSE 8000
CMD ["/bin/sh", "-e", "/opt/run"]
