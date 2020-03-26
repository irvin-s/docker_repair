FROM mozillamarketplace/centos-python27-mkt:latest

ADD yum/mysql.repo /etc/yum.repos.d/mysql.repo
RUN yum install -y \
    mysql-community-server \
    mysql-community-devel \
    # The MySQL Python wheel used on production is compiled with
    # libmysqlclient_r.so.16, so we need to install this to get
    # that wheel to work.
    mysql-community-libs-compat-5.6.14-3.el6.x86_64 \
    && yum clean all
