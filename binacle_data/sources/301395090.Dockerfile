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
                    mtools \
                    nginx \
                    mkisofs \
                    python-flask \
                    gcc \
                    python-devel

RUN curl https://bootstrap.pypa.io/get-pip.py | python - && \
    pip install ucsmsdk ucscsdk imcsdk flask_cors sshpubkeys

# make output of nginx logs go to stdout so we see in docker.
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

ADD patches/ucscsdk/ucscmeta.py /usr/lib/python2.7/site-packages/ucscsdk/
ADD patches/ucscsdk/ConfigRemoteResolveChildrenMeta.py /usr/lib/python2.7/site-packages/ucscsdk/methodmeta/
