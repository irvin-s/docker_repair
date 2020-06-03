FROM oneops/centos7

RUN yum makecache fast
RUN yum -y remove ruby ruby-libs
RUN yum -y install gdbm-devel libdb4-devel libffi-devel libyaml libyaml-devel ncurses-devel openssl-devel readline-devel tcl-devel
WORKDIR /root
RUN mkdir -p rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
RUN wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz -P rpmbuild/SOURCES
COPY ruby22x.spec rpmbuild/SPECS/
RUN rpmbuild -bb rpmbuild/SPECS/ruby22x.spec
RUN yum -y localinstall rpmbuild/RPMS/x86_64/ruby-2.2.3-1.el7.centos.x86_64.rpm

RUN yum -y install graphviz
RUN gem install rails --no-rdoc --no-ri
COPY display.ini /etc/supervisord.d/display.ini
COPY display.sh /opt/display.sh

ENV OO_HOME /home/oneops
ENV RAILS_ENV=development
ENV OODB_USERNAME=kloopz
ENV OODB_PASSWORD=kloopz
EXPOSE 3000
