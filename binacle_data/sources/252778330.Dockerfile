FROM alpine  
MAINTAINER Paul Pham <docker@aquaron.com>  
  
ENV \  
_image=aquaron/anf \  
_etc=/etc/nginx \  
_root=/usr/share/nginx \  
_log=/var/log/nginx \  
_sock=/tmp/cgi.sock \  
PERL5LIB=/usr/share/nginx/lib  
  
COPY data /data  
  
RUN apk add --no-cache \  
bash \  
nginx \  
fcgiwrap \  
perl \  
make \  
curl \  
wget \  
gcc \  
g++ \  
perl-dev \  
mysql-dev \  
  
&& ln -s /usr/bin/perl /usr/local/bin/perl \  
&& curl -sL http://cpanmin.us -o /usr/bin/cpanm; chmod +x /usr/bin/cpanm \  
&& cpanm -n \  
CGI\  
JSON \  
JSON::XS \  
DBD::mysql \  
Apache::Session::MySQL \  
Redis \  
Crypt::ScryptKDF \  
Crypt::CBC \  
File::Slurp \  
CSS::Inliner \  
&& rm -rf /root/.cpanm \  
  
&& mv /data/misc/bash-prompt ~/.profile \  
&& mv /data/bin/* /usr/bin \  
&& apk del --no-cache g++ gcc make curl wget perl-dev  
  
ONBUILD RUN apk add --no-cache openssl g++ gcc make perl-dev expat-dev  
  
VOLUME $_root $_log $_etc  
ENTRYPOINT [ "runme.sh" ]  
CMD [ "daemon" ]  

