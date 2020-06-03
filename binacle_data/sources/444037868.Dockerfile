FROM centos:centos7

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-08-10

ADD start /start
RUN chmod +x /start
ENTRYPOINT ["/start"]
CMD ["start"]

