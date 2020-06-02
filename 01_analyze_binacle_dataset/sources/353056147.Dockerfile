FROM centos:7

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

# http://www.cyberciti.biz/faq/linux-inotify-examples-to-replicate-directories/
# http://www.thekelleys.org.uk/dnsmasq/doc.html
RUN yum install -y dnsmasq http://dl.fedoraproject.org/pub/epel/7/x86_64/i/incron-0.5.10-8.el7.x86_64.rpm; \
    yum clean all

RUN mkdir /var/spool/incron/root

COPY support/dnsmasq_docker.conf         /etc/dnsmasq.d/
COPY support/incron_dnsmaq_monitor.conf  /etc/incron.d/
COPY support/run.sh /

# set the Google public DNS service to external lookups in dnsmasq service
#RUN echo "nameserver 8.8.8.8" >> /etc/resolv.dnsmasq.conf; \
RUN echo "root" > /etc/incron.allow

# every container whats use a DNS service 
# for service discorey have to mount this volume.
VOLUME /dnsmasq.hosts

# DNS service's port
EXPOSE 53

CMD ["/run.sh"]
