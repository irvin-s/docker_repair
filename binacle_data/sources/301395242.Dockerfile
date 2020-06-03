FROM centos
MAINTAINER vallard@benincosa.com
# install additional repositorys
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm \
            http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el7/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm \
            https://forensics.cert.org/cert-forensics-tools-release-el7.rpm
# install required packages. 
RUN yum -y install  xorriso \
                    python-jinja2 \
                    PyYAML \
                    fuseext2 \
                    nginx \
                    mkisofs
# make output of nginx logs go to stdout so we see in docker.
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log
# allow autoindexing of kubam
ADD files/default.conf /etc/nginx/conf.d
# turn daemon off of default nginx server.
ADD files/nginx.conf /etc/nginx/nginx.conf 
# files for scripts to run 
ADD files/stage1 /usr/share/kubam/stage1
ADD templates /usr/share/kubam/templates
# get our scripts installed. 
ADD scripts/* /usr/bin/
EXPOSE 80
CMD ["/bin/bash", "/usr/bin/init.sh"]
