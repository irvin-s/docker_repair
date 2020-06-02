FROM r-base  
MAINTAINER Carl Saturnino <cosaturn@gmail.com>  
  
ENV BUILD_PACKAGES num-utils build-essential git  
ENV CPAN_PACKAGES HTML::Strip  
  
RUN apt-get -y update && \  
apt-get -y upgrade  
RUN apt-get install -y $BUILD_PACKAGES  
  
ENV RUBY_PACKAGES ruby ruby-dev  
RUN apt-get install -y $RUBY_PACKAGES && \  
rm -rf /var/cache/apk/*  
RUN gem install --no-document io-console t  
  
RUN cpan install $CPAN_PACKAGES  
  
ENV UTILS_PACKAGES sudo curl whois bsdmainutils  
RUN apt-get install -y $UTILS_PACKAGES  
  
ENTRYPOINT ["r"]  

