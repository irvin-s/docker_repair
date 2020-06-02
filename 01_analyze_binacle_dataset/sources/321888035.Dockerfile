FROM centos:latest

RUN rpm --import \
        /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 \
        http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
    && yum install -y -q epel-release

RUN rpm --import https://nginx.org/keys/nginx_signing.key \
    && yum install -y -q nginx
RUN mkdir /etc/nginx/sites-enabled

ADD nginx.conf /etc/nginx/
ADD symfony.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony

RUN echo "root:root" | chpasswd \
    && groupadd -r -g 1000 web1 \
    && useradd -r -u 1000 -d /home/web1 -m -p \$1\$abc\$z6zw.AIqtpbwKbR78LIWi0 -g web1 web1 \
    && ln -s /home/web1/bin/blz.lut2 /etc/blz.lut2

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
