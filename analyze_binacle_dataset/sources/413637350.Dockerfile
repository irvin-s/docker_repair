FROM centos:7

RUN rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
RUN yum install -y -q puppet-agent

WORKDIR /etc/puppetlabs/code/environments/production

# globalのhieraを使用しないようにするため
RUN echo -n > /etc/puppetlabs/puppet/hiera.ymaml

CMD ["/usr/sbin/init"]
