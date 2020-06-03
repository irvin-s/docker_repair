FROM ruby:alpine  
MAINTAINER Arno0x0x - https://twitter.com/Arno0x0x  
  
ADD ./entry_point.sh /entry_point.sh  
  
RUN apk update \  
&& apk add git ruby-dev build-base gcc abuild binutils binutils-doc gcc-doc \  
&& gem install bundler \  
&& git clone https://github.com/iagox86/dnscat2.git \  
&& chmod +x /entry_point.sh  
  
WORKDIR /dnscat2/server  
RUN gem install bundler \  
&& bundle install  
  
WORKDIR /  
  
EXPOSE 53/udp  
EXPOSE 53  
ENTRYPOINT ["/entry_point.sh"]

