FROM alpine:latest

MAINTAINER Till Wiese <mail-github.com@till-wiese.de>

RUN apk add --no-cache diffutils grep perl-fcgi perl-cgi perl-cgi-session \
  perl-error perl-json perl-module-build perl-uri \
  ca-certificates tar build-base lighttpd \
  && rm -rf /usr/share/nginx/html/* \
  && wget -q -O- https://sourceforge.net/projects/foswiki/files/latest/download \
  | tar --strip-components=1 -C /usr/share/nginx/html/ -xzvf - \
  && find /usr/share/nginx/html -exec chown -fR nginx:nginx {} \; \
  && export PERL_MM_USE_DEFAULT=1 \
  && perl -MCPAN -e 'install Crypt::PasswdMD5' \
  && perl -MCPAN -e 'install File::Copy::Recursive' \
  && perl -MCPAN -e 'install Algorithm::Diff' \
  && perl -MCPAN -e 'install HTML::Tree' 
  # && perl -MCPAN -e 'install FCGI::ProcManager'

ENV FOSWIKI_ROOT="/usr/share/nginx/html" \
  FOSWIKI_FCGI="foswiki.fcgi" \
  FOSWIKI_BIND="127.0.0.1:9000"
