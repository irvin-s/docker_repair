FROM centos:centos7

MAINTAINER Graylog, Inc. <hello@graylog.com>

# Install required packages to install the fpm-cookery gem.
RUN yum clean all
RUN yum install -y rubygems ruby-devel make gcc tar rpm-build curl

# Install the fpm-cookery gem from rubygems.org.
RUN gem install fpm-cookery --no-ri --no-rdoc --version 0.25.0

# Remove cached packages and metadata to keep images small.
RUN yum clean all
