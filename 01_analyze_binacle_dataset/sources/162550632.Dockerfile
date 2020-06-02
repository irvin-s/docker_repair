FROM mozillamarketplace/centos-python27-mkt:latest

RUN yum install -y memcached

EXPOSE 11211
