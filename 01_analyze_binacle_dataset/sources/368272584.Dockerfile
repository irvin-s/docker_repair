FROM devopsil/puppet
#FROM centos:centos6

MAINTAINER Carlos Sanchez <carlos@apache.org>

# ------------------------------ Using devopsil/puppet ------------------------------

# So we don't need to install Puppet

#RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && \
#    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

# Need to enable centosplus for the image libselinux issue
#RUN yum install -y yum-utils
#RUN yum-config-manager --enable centosplus

#RUN yum update -y
#RUN yum install -y puppet tar

# ------------------------------ Using devopsil/puppet ------------------------------

ADD modules/ /etc/puppet/modules/

ADD site.pp /etc/puppet/manifests/
ADD common.yaml /var/lib/hiera/common.yaml

RUN puppet apply /etc/puppet/manifests/site.pp --verbose --detailed-exitcodes || [ $? -eq 2 ]

ADD cmd.sh /cmd.sh

#ENV JENKINS_USERNAME jenkins
#ENV JENKINS_PASSWORD jenkins
#ENV JENKINS_MASTER http://jenkins:8080

CMD su jenkins-slave -c '/bin/sh /cmd.sh'
