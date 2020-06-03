FROM centos
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN echo 'NETWORKING=yes' > /etc/sysconfig/network

# Install Postgresql
RUN rpm -i http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm
RUN yum install -y postgresql93-devel postgresql93 postgresql93-server postgresql93-contrib
ENV PATH /usr/pgsql-9.3/bin:$PATH

RUN service postgresql-9.3 initdb en_AU.UTF-8
ADD pg_hba.conf /var/lib/pgsql/9.3/data/pg_hba.conf
RUN service postgresql-9.3 start && chkconfig postgresql-9.3 on && su postgres -c "createuser -s rea-app"
USER postgres
EXPOSE 5432
CMD ["/usr/pgsql-9.3/bin/postgres", "-D", "/var/lib/pgsql/9.3/data", "-i", "-h", "0.0.0.0"]
