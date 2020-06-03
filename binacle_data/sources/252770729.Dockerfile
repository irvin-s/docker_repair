FROM perl:latest  
RUN cpan App::Sqitch  
RUN cpan DBD::Pg  
RUN apt-get update  
RUN apt-get install -y postgresql-client  
RUN apt-get clean  
ADD entrypoint.sh /entrypoint.sh  
VOLUME /src  
WORKDIR /src  
ENV HOME=/src  
ENTRYPOINT /entrypoint.sh  

