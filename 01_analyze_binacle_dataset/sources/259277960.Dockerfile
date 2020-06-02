FROM centos:centos7

EXPOSE 8181

RUN yum -y -q install epel-release go git wget make && \
    yum -y -q install python-pip && \
    yum clean all && \
    pip install prometheus_client

RUN mkdir -p /opt/example

COPY prometheus-python.py /opt/example

# Set a default user, any value will work here.
# Otherwise the default is root and can fail in certain OpenShift installations
USER 12345

ENTRYPOINT ["/opt/example/prometheus-python.py"]
