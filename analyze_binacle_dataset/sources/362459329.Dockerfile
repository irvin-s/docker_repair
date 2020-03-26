# Dockerfile
FROM centos:7

RUN yum update -y && yum install git python-requests -y

COPY ./fetch_and_install_deps.py /

RUN chmod 500 /fetch_and_install_deps.py

ENTRYPOINT ["/fetch_and_install_deps.py", "/var/wdir"]
# by default, the following will be used for the last execution:
CMD ["/var/wdir/f5-openstack-agent-dist/rpms/build/f5-openstack-agent-*.el7.noarch.rpm"]
