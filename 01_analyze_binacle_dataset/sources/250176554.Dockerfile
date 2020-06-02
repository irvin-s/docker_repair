FROM registry.access.redhat.com/rhel7.6
MAINTAINER https://github.com/JacobCallahan

ENV HOME /root
WORKDIR /root

RUN sed -i -e 's/os.path.exists(HOST_CONFIG_DIR)/False/g' /usr/lib64/python2.7/site-packages/rhsm/config.py
RUN echo "{\"virt.host_type\": \"Not Applicable\", \"virt.is_guest\": \"False\"}" > /etc/rhsm/facts/custom.facts
ADD startup.sh /tmp/
RUN chmod +x /tmp/startup.sh
ADD hostname-3.13-3.el7.x86_64.rpm /tmp/
RUN yum -y localinstall /tmp/hostname-3.13-3.el7.x86_64.rpm

EXPOSE 22

CMD /tmp/startup.sh
