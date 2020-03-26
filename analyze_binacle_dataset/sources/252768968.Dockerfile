FROM php:7-apache  
  
MAINTAINER Andrey Starodubtsev, https://github.com/andrey-starodubtsev  
  
RUN apt-get update && \  
apt-get install -y \  
libdbd-mysql-perl \  
libnet-ssh2-perl \  
libxml-sax-expat-perl \  
perl && \  
PERL_MM_USE_DEFAULT=1 cpan -i \  
boolean \  
Crypt::RC4 \  
Data::Dump \  
DBI \  
File::Which \  
JSON \  
MIME::Lite \  
XML::Simple  
  
# fail  
# RUN cpan -i \  
# Term::ReadKey \  
# Tk  
  
ENV EMBED_ENV qa  

