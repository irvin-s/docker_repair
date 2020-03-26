FROM openshift/perl-516-centos7  
  
MAINTAINER Askannon <askannon@flexarc.com>  
  
COPY ./s2i/bin/ $STI_SCRIPTS_PATH  

