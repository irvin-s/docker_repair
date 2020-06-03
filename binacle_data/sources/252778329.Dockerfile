FROM aquaron/anf:debian  
MAINTAINER Paul Pham <docker@aquaron.com>  
  
ENV \  
_image=aquaron/anf-large:debian \  
_prince=prince-11-linux-generic-x86_64  
  
RUN apt-get update -q && apt-get install -qy \  
wget \  
libxml2-dev \  
perlmagick \  
libnet-ssleay-perl \  
libcrypt-ssleay-perl \  
libxml-libxml-perl \  
  
&& wget http://www.princexml.com/download/${_prince}.tar.gz -O - | tar xz \  
&& echo "" | ${_prince}/install.sh \  
&& rm -rf ${_prince} \  
  
&& cpanm -n \  
Plack \  
Flickr::API \  
Flickr::Upload \  
Net::Twitter \  
WWW::Facebook::API \  
LWP::Authen::OAuth \  
PDF::API2 \  
XML::RSS \  
XML::FeedPP \  
Crypt::DES \  
Crypt::Blowfish \  
DateTime::Format::W3CDTF \  
String::Random \  
Text::CSV \  
Archive::Zip \  
  
&& apt-get purge -qy g++ gcc make wget \  
&& apt-get autoremove -qy \  
&& rm -rf /root/.cpanm /var/lib/apt/lists/*  
  

