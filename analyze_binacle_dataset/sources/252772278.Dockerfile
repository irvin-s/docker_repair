FROM perl:5.24  
MAINTAINER Viruslab Systems, Avast Software  
  
COPY cpanfile /root/cpanfile  
RUN cpanm --verbose --notest Term::ReadKey && rm -rf ~/.cpanm  
RUN cpanm --verbose App::cpm && rm -rf ~/.cpanm  
RUN cpm install --test \--verbose -g && rm -rf ~/.cpanm  

