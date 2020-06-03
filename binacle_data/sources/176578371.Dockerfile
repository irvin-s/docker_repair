FROM progrium/busybox
RUN opkg-install curl bash

RUN curl -skL https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | \
   gunzip -c > /root/go-cron && chmod a+x /root/go-cron

RUN curl -skLo /root/ep https://github.com/kreuzwerker/envplate/releases/download/v0.0.4/ep-linux && chmod +x /root/ep

RUN curl -skLo /root/etcd-backup https://github.com/odise/etcd-backup/releases/download/v0.0.1/etcd-backup-linux && chmod +x /root/etcd-backup

RUN curl -skL https://github.com/rlmcpherson/s3gof3r/releases/download/v0.4.9/gof3r_0.4.9_linux_amd64.tar.gz | \
   gunzip | tar -x -C /tmp -f - && \
   mv /tmp/gof3r_0.4.9_linux_amd64/gof3r /root && \
   chmod +x /root/gof3r && \
   rm -rf /tmp/gof3r_0.4.9_linux_amd64/gof3r

ADD https://raw.githubusercontent.com/bagder/ca-bundle/master/ca-bundle.crt /etc/ssl/ca-bundle.pem

# add scheduler and create jobs entrypoint
ADD scheduler.sh /root/scheduler.sh
RUN chmod a+x /root/scheduler.sh
RUN mkdir /jobs

# thats our default
ADD etcdbackupjob.sh /jobs/
ADD elasticsearchbackupjob.sh /jobs/
RUN chmod a+x /jobs/*

EXPOSE 18080

# variable substitution and scheduler start
CMD [ "/root/ep", \
    "-v", "/jobs/*", \
    "-v", "/root/scheduler.sh", \
    "--", "/bin/sh", "/root/scheduler.sh" ]