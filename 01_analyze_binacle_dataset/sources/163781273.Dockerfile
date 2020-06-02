# https://rt-wiki.bestpractical.com/wiki/CentOS7Install
# https://github.com/okfn/docker-rt/blob/master/Dockerfile

FROM lenz/whaleware

EXPOSE 80

RUN yum install -y wget lsof nano tar jq mysql && \
    wget -P /etc/yum.repos.d http://yum.loway.ch/loway.repo

RUN yum install -y tzdata expat gd graphviz mysql-server mysql-devel openssl expat-devel gd-devel graphviz-devel mariadb-devel openssl-devel perl perl-CPAN wget screen mod_fcgid which
RUN yum groupinstall -y "Development Tools" "Web Server"

RUN curl -L http://cpanmin.us | perl - App::cpanminus

ENV RTVER 4.0.4


RUN mkdir -p /opt
RUN wget https://download.bestpractical.com/pub/rt/release/rt-${RTVER}.tar.gz
RUN tar xvzf rt-${RTVER}.tar.gz -C /opt
WORKDIR /opt/rt-${RTVER}
RUN ./configure --enable-graphviz --enable-gd --with-web-user=apache --with-web-group=apache

RUN cpanm XSLoader --force
RUN cpanm GnuPG::Interface
RUN cpanm Plack
RUN cpanm GD --force

RUN cpanm DateTime
RUN cpanm Encode 
RUN cpanm DateTime::Locale
RUN cpanm MIME::Entity
RUN cpanm XML::RSS
RUN cpanm HTML::Mason
RUN cpanm DBD::mysql
RUN cpanm Plack::Handler::Starlet
RUN cpanm Term::ReadKey

RUN cpanm Term::ReadKey 
RUN cpanm Class::ReturnValue 
RUN cpanm Text::Quoted 
RUN cpanm Regexp::IPv6 
RUN cpanm CSS::Squish 
RUN cpanm Module::Versions::Report 
RUN cpanm Locale::Maketext::Lexicon 
RUN cpanm Text::Password::Pronounceable 
RUN cpanm Time::ParseDate 
RUN cpanm Tree::Simple 
RUN cpanm Text::Template 
RUN cpanm HTML::Quoted 
RUN cpanm HTML::Scrubber 
RUN cpanm DBIx::SearchBuilder 
RUN cpanm Regexp::Common 
RUN cpanm Cache::Simple::TimedExpiry 
RUN cpanm Class::Accessor 
RUN cpanm Locale::Maketext::Fuzzy 
RUN cpanm Text::Wrapper 
RUN cpanm Regexp::Common::net::CIDR 
RUN cpanm Net::CIDR 
RUN cpanm Log::Dispatch 
RUN cpanm UNIVERSAL::require 
RUN cpanm Email::Address 
RUN cpanm HTML::RewriteAttributes 
RUN cpanm Data::ICal 
RUN cpanm Term::ReadKey 
RUN cpanm PerlIO::eol 
RUN cpanm IPC::Run 
RUN cpanm GraphViz 
RUN cpanm GD::Graph 
RUN cpanm GD::Text 
RUN cpanm CGI::Emulate::PSGI 
RUN cpanm CGI::PSGI 
RUN cpanm HTML::Mason::PSGIHandler 
RUN cpanm CGI 
RUN cpanm Plack::Handler::Starlet 
RUN cpanm FCGI::ProcManager 
RUN cpanm FCGI 
RUN cpanm Class::ReturnValue 
RUN cpanm HTML::Quoted 
RUN cpanm HTML::Scrubber 
RUN cpanm Text::Quoted 
RUN cpanm Regexp::IPv6 
RUN cpanm DBIx::SearchBuilder 
RUN cpanm CSS::Squish 
RUN cpanm Regexp::Common 
RUN cpanm Module::Versions::Report 
RUN cpanm Cache::Simple::TimedExpiry 
RUN cpanm Locale::Maketext::Lexicon 
RUN cpanm Class::Accessor 
RUN cpanm Locale::Maketext::Fuzzy 
RUN cpanm Text::Password::Pronounceable 
RUN cpanm Text::Wrapper 
RUN cpanm Time::ParseDate 
RUN cpanm Regexp::Common::net::CIDR 
RUN cpanm Net::CIDR 
RUN cpanm Log::Dispatch 
RUN cpanm UNIVERSAL::require 
RUN cpanm Text::Template 
RUN cpanm Tree::Simple 
RUN cpanm Email::Address 


RUN RT_FIX_DEPS_CMD=/usr/local/bin/cpanm      make fixdeps
RUN make testdeps
RUN make install


