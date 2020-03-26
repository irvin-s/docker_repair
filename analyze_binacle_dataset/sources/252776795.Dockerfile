FROM ccakes/perl-runtime:latest  
MAINTAINER cam.daniel@gmail.com  
  
RUN cpanm -i Perl::Critic \  
# Perl::Critic::Git \  
Perl::Critic::Moose \  
Perl::Critic::Bangs \  
Perl::Critic::Lokku \  
Perl::Critic::Pulp \  
Perl::Critic::StricterSubs \  
Perl::Critic::Compatibility  
  
RUN cpanm -i Devel::Cover \  
Devel::Cover::Report::Clover \  
Devel::Cover::Report::Codecov \  
Devel::Cover::Report::Kritika \  
Devel::Cover::Report::Coveralls \  
Devel::Cover::Report::OwnServer  
# Devel::Cover::Report::Phabricator

