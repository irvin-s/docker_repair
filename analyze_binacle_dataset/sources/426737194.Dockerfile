# perl-carton
#
# VERSION 0.1

FROM centos
MAINTAINER Dave Goehrig dave@dloh.org
RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN curl -L http://install.perlbrew.pl | bash

# select perl-5.18.1 by default
RUN echo "source ~/perl5/perlbrew/etc/bashrc && perlbrew use perl-5.18.1" > /etc/profile.d/perl.sh
RUN source ~/perl5/perlbrew/etc/bashrc && perlbrew install perl-5.18.1
RUN source ~/perl5/perlbrew/etc/bashrc && perlbrew use perl-5.18.1 && perlbrew install-cpanm
RUN source ~/perl5/perlbrew/etc/bashrc && perlbrew use perl-5.18.1 && cpanm Carton
