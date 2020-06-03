FROM rouge8/pythons  
MAINTAINER Douglas Creager <dcreager@dcreager.net>  
  
ADD postgresql.trusty.list /etc/apt/sources.list.d/  
RUN apt-key adv \  
\--keyserver keyserver.ubuntu.com \  
\--recv B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -yq \  
libpq-dev python-psycopg2 build-essential \  
\--no-install-recommends  
  
# Install Docker from Docker Inc. repositories.  
RUN curl -sSL https://get.docker.com/ubuntu/ | sh  

