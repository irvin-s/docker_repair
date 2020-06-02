FROM ubuntu:14.04.4  
MAINTAINER Adam Diehl <adadiehl@umich.edu>  
  
# Install gcc and make (not present by default on the ubuntu image)  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get -y install gcc make  
  
# Install the Catalyst Framework and supporting PERL modules  
RUN sudo cpan App::cpanminus  
RUN sudo cpanm Catalyst::Runtime  
RUN sudo cpanm Catalyst::Devel  
RUN sudo cpanm Template  
RUN sudo cpanm Catalyst::Helper::View::TT  
RUN sudo cpanm DBIx::Class  
RUN sudo cpanm Catalyst::Helper::Model::DBIC::Schema  
RUN sudo cpanm DBIx::Class::Schema::Loader  
RUN sudo cpanm MooseX::NonMoose  
RUN sudo cpanm JSON  
RUN sudo cpanm FCGI  
RUN sudo cpanm FCGI::ProcManager::MaxRequests  
  
# Install mysql client (Not necessary but handy)  
RUN apt-get -y install mysql-client  
  
# Install nginx  
RUN apt-get -y install nginx  
RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig  
COPY nginx.conf /etc/nginx/  
RUN cp /etc/nginx/fastcgi_params /etc/nginx/fastcgi_params.orig  
COPY fastcgi_params /etc/nginx/  
  
# Copy in the fastcgi init.d script  
COPY fastcgi /etc/init.d/  
RUN chmod 755 /etc/init.d/fastcgi  
RUN update-rc.d fastcgi defaults  
  
# Install monit  
RUN apt-get -y install wget  
RUN wget https://mmonit.com/monit/dist/binary/5.18/monit-5.18-linux-x64.tar.gz  
RUN tar -xvzf monit-5.18-linux-x64.tar.gz  
RUN cp /monit-5.18/bin/monit /usr/bin/monit  
  
COPY browser_up.sh /usr/bin/  
  
EXPOSE 3000 80 8080  
# For some reason this makes the container choke, so just  
# start up the server and browser after launching the container  
# for now.  
#CMD ["browser_up.sh"]  

