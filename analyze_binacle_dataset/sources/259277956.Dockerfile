FROM centos:centos7

# our example plans to expose one of these three
EXPOSE 8080
EXPOSE 8181
EXPOSE 8282

RUN yum -y -q install epel-release go git wget make && \
    yum -y -q install python-pip && \
    yum clean all && \
    pip install prometheus_client

RUN mkdir -p /opt/example

COPY multiple-endpoints.py /opt/example

# Set a default user, any value will work here.
# Otherwise the default is root and can fail in certain OpenShift installations
USER 12345

ENTRYPOINT ["/opt/example/multiple-endpoints.py"]
