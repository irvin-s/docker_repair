FROM perl:latest-threaded  
  
RUN \  
apt-get update \  
&& apt-get install -y libdbd-pg-perl postgresql-client libpq-dev  
  
RUN \  
cpan App::Sqitch DBD::Pg  

