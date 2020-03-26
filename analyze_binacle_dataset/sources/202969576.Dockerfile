FROM sipcapture/homer-webapp
MAINTAINER L. Mangani <lorenzo.mangani@gmail.com>
ENV BUILD_DATE 2017-04-17
COPY run.sh /run.sh
RUN chmod a+rx /run.sh
ENTRYPOINT ["/run.sh"]
