# MySQL Server
#
# VERSION               0.0.1

FROM     base
MAINTAINER Prabhat Khera "prabhat.khera@gmail.com"


# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

RUN apt-get update

# Bundle everything
ADD . /src

# Install MySQL server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix configuration
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Setup admin user
RUN /src/mysql-setup.sh

EXPOSE 3306
CMD ["/src/start.sh"]
