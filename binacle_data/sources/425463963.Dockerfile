FROM devopsil/base

# for JDK use: RUN yum install -y java-1.7.0-openjdk-devel
RUN yum install -y java-1.7.0-openjdk \
    && yum clean all

ENTRYPOINT [ "/bin/sh" ]
