FROM centos:5

ENV PATH=${PATH}:/usr/local/rvm/bin LANG=en_US.utf8

RUN buildDeps='curl libyaml-devel glibc-headers autoconf gcc-c++ glibc-devel patch readline-devel zlib-devel libffi-devel openssl-devel make bzip2 automake libtool bison sqlite-devel' && \
    yum update && yum install -y epel-release && yum install -y $buildDeps && \
    curl http://cache.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p374.tar.gz | tar zxC /tmp/ && \
    cd /tmp/ruby-1.8.7-p374 && ./configure && make && make install && \
    curl http://pkgs.fedoraproject.org/repo/pkgs/rubygems/rubygems-1.8.25.tgz/1376a258d43c53750a8df30e67853e10/rubygems-1.8.25.tgz | tar zxC /tmp/ && \
    cd /tmp/rubygems-1.8.25 && ruby setup.rb && \
    gem update --system 1.8.25 && \
    gem install bundler --no-ri --no-rdoc && \
    rm -Rf /tmp/ruby* && \
    yum clean all
