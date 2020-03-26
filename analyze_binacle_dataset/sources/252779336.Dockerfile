FROM python:3.5.3  
  
RUN apt-get update \  
&& apt-get install -y curl \  
&& apt-get install -y make \  
&& apt-get install -y git \  
&& apt-get install -y libcairo2-dev \  
&& apt-get install -y libffi-dev \  
&& apt-get install -y libpango1.0-dev \  
&& apt-get install -y postgresql-9.4 \  
&& apt-get install -y postgresql-contrib-9.4 \  
&& apt-get install -y postgresql-server-dev-9.4 \  
&& echo "local all postgres trust" > /etc/postgresql/9.4/main/pg_hba.conf \  
&& curl -sL https://deb.nodesource.com/setup_6.x | bash - \  
&& apt-get install -y nodejs \  
&& npm install -g npm \  
&& npm install -g yarn  

