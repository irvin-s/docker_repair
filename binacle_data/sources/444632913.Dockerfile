FROM fujin/golang
MAINTAINER AJ Christensen <aj@junglist.io>
ADD install.sh /
RUN /install.sh
ADD start.sh /
CMD /start.sh
