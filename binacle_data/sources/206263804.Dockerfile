FROM registry.access.redhat.com/rhel7:7.4-129

COPY logrotate.sh /

RUN chmod 755 /logrotate.sh

ENTRYPOINT /logrotate.sh
