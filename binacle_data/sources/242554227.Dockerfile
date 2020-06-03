FROM centos:centos7
ENV LANG=en_US.UTF-8

LABEL maintainer="The University of Auckland" \
	description="NZ ORCiD Hub Application Image with Development support"

# ADD http://download.opensuse.org/repositories/security://shibboleth/CentOS_7/security:shibboleth.repo /etc/yum.repos.d/shibboleth.repo
ADD https://shibboleth.net/cgi-bin/sp_repo.cgi?platform=CentOS_7 /etc/yum.repos.d/shibboleth.repo
# fix download.opensuse.org not available
##RUN sed -i 's|download|downloadcontent|g' /etc/yum.repos.d/shibboleth.repo
COPY conf/app.wsgi /var/www/html/
# prefix "ZZ" added, that it gest inluded the very end (after Shibboleth gets loaded)
COPY conf/app.conf /etc/httpd/conf.d/ZZ-app.conf
COPY requirements.txt /
# COPY setup.py /
# COPY orcid_api /orcid_api
# COPY orcid_hub /orcid_hub
COPY setup.* orcid* /
COPY run-app /usr/local/bin/
COPY ./conf /conf

# && chmod +x /etc/sysconfig/shibd /etc/shibboleth/shibd-redhat \
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
    && yum -y update \
    && yum -y install \
        shibboleth.x86_64 \
    	httpd \
        mod_ssl \
    	gcc.x86_64 \
        httpd-devel.x86_64 \
        python36u.x86_64 \
        python36u-devel.x86_64 \
        python36u-pip \
        git \
    && echo $'RPMs installed...' \
    && pip3.6 install -U pip \
    && pip install -U mod_wsgi psycopg2-binary \
    && pip install -U -r requirements.txt \
    && /usr/bin/mod_wsgi-express module-config >/etc/httpd/conf.modules.d/10-wsgi.conf \
    && [ -d /var/run/lock ] || mkdir -p /var/run/lock \
    && [ -d /var/lock/subsys/ ] || mkdir -p /var/lock/subsys/ \
    && echo $'export LD_LIBRARY_PATH=/opt/shibboleth/lib64:$LD_LIBRARY_PATH\n' > /etc/sysconfig/shibd \
    && chmod +x /etc/shibboleth/shibd-redhat \
    && yum erase -y \
        alsa-lib \
        apr-util-devel \
        copy-jdk-configs \
        cpp \
        cyrus-sasl-devel \
        expat-devel \
        fontconfig \
        fontpackages-filesystem \
        freetype \
        gcc \
        giflib \
        git \
        glibc-devel \
        glibc-headers \
        httpd-devel \
        javapackages-tools \
        kernel-headers \
        libdb-devel \
        libfontenc \
        libICE \
        libjpeg-turbo \
        libpng \
        libSM \
        libX11 \
        libX11-common \
        libXau \
        libxcb \
        libXcomposite \
        libXext \
        libXfont \
        libXi \
        libXrender \
        libxslt \
        libXtst \
        lksctp-tools \
        openldap-devel \
        perl \
        python36u-devel \
        python36u-pip \
        python-javapackages \
        python-lxml \
        ttmkfdir \
        xorg-x11-fonts-Type1 \
        xorg-x11-font-utils \
        java-1.8.0-openjdk-headless \
        tzdata-java \
    && chmod +x /usr/local/bin/run-app \
    && cd /var/lib/rpm \
    && rm -rf __db* \
    && rpm --rebuilddb \
    && yum -y clean all \
    && rm -rf /var/cache/yum \
    && rm -rf $HOME/.pip/cache \
    && rm -rf /var/cache/*/* /anaconda-post.log \
    && rm -rf /requirements.txt /swagger_client.egg-info /setup.* /orcid_*


EXPOSE 80 443

CMD ["run-app"]
