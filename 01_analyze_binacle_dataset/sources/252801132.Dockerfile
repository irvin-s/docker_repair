# Simple reverse-proxy with an authtoken stuck on the front end.  
#  
# Chris Weyl <chris.weyl@dreamhost.com> 2016  
FROM alpine:3.3  
MAINTAINER Chris Weyl <chris.weyl@dreamhost.com>  
  
ADD cpanm /  
  
# install everything we can through the package repos.  
RUN apk add --update \  
ca-certificates make \  
perl perl-plack perl-lwp-protocol-https perl-canary-stability \  
perl-extutils-helpers perl-extutils-config perl-extutils-installpaths \  
perl-module-build-tiny \  
&& rm -rf /var/cache/apk/*  
  
# ...and the rest of our deps from the CPAN  
RUN PERL_CPANM_HOME=/cpanm-scratch perl /cpanm -q \  
Plack::App::Proxy \  
Plack::Middleware::Auth::AccessToken \  
Path::Tiny \  
&& rm -rf /cpanm-scratch  
  
ADD app.psgi /  
  
ENTRYPOINT plackup --listen 0.0.0.0:8080  

