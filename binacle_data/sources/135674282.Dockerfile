FROM centos:centos6

MAINTAINER wookietreiber

# base system upgrade and system dependencies
RUN yum upgrade -y && \
    yum install -y \
      gcc-c++ automake make \
      apr-devel expat-devel rrdtool-devel zlib-devel \
      httpd php rsync wget tar && \
    yum clean all

# pcre dependency
RUN cd /usr/src && \
    wget -q http://sourceforge.net/projects/pcre/files/pcre/8.33/pcre-8.33.tar.gz/download -O pcre-8.33.tar.gz && \
    tar xzf pcre-8.33.tar.gz && \
    cd pcre-8.33 && \
    ./configure --prefix=/usr && \
    make && make install && ldconfig && \
    rm -rf /usr/src/pcre-8.33*

# confuse dependency
RUN cd /usr/src && \
    wget -q http://savannah.nongnu.org/download/confuse/confuse-2.7.tar.gz && \
    tar xzf confuse-2.7.tar.gz && \
    cd confuse-2.7 && \
    ./configure --prefix=/usr --enable-shared && \
    make && make install && ldconfig && \
    rm -rf /usr/src/confuse-2.7*

# ganglia-core
RUN cd /usr/src && \
    wget -q http://downloads.sourceforge.net/ganglia/ganglia-3.6.0.tar.gz && \
    tar xzf ganglia-3.6.0.tar.gz && \
    cd /usr/src/ganglia-3.6.0 && \
    ./configure --prefix=/usr --sysconfdir=/etc/ganglia/ --sbindir=/usr/sbin/ --with-gmetad --enable-gexec --enable-status && \
    make && make install && ldconfig && \
    rm -rf /usr/src/ganglia-3.6.0*

# ganglia-web
RUN cd /usr/src && \
    wget -q http://downloads.sourceforge.net/ganglia/ganglia-web-3.5.10.tar.gz && \
    tar xzf ganglia-web-3.5.10.tar.gz && \
    mv ganglia-web-3.5.10 /var/www/html/ganglia && \
    cd /var/www/html/ganglia && \
    make install && \
    rm -rf /usr/src/ganglia-web-3.5.10*

# add the ganglia user and group
RUN useradd -r -U -d /var/lib/ganglia -s /bin/false ganglia

# create the default gmond config file, with the default gmetad cluster name
RUN gmond -t \
    | sed 's/name = "unspecified"/name = "my cluster"/' \
    > /etc/ganglia/gmond.conf

# add the start script
ADD start.sh start.sh

# entrypoint is the start script
ENTRYPOINT ["bash","start.sh"]

# default is with gmond for seeing something
CMD ["--with-gmond"]
