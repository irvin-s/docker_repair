FROM fujin/go-agent
MAINTAINER AJ Christensen <aj@junglist.io>
ADD dependencies.sh /
RUN /dependencies.sh
CMD /start.sh