FROM centos
MAINTAINER  wangbing
RUN echo "copy files..."
COPY target/* /tmp/
RUN ls /tmp/
CMD ["sleep","3000"]
