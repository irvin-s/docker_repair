FROM breakyboy/ghost:0.6.2  
MAINTAINER Andres Rojas <andres@conpat.io>  
ENV REFRESHED_AT 2015-05-04  
  
RUN apt-get -qq update \  
&& apt-get -qqy install xz-utils  

