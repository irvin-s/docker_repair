FROM java:7u71

MAINTAINER hekonsek@gmail.com

RUN mkdir /fuse
ADD target/jboss-fuse-6.1.0.redhat-379 /opt/jboss-fuse-6.1.0.redhat-379

ENTRYPOINT ["/opt/jboss-fuse-6.1.0.redhat-379/bin/fuse"]
CMD ["server"]