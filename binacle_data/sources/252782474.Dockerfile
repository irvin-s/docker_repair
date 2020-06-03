FROM cl0sey/aspnet-dnx451-mvc  
  
RUN apt-get update \  
&& apt-get install -y \  
curl \  
git-core \  
&& apt-get -y clean \  
&& apt-get -y purge \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& curl -sL https://deb.nodesource.com/setup_4.x | bash - \  
&& apt-get install -y nodejs \  
&& npm install -g bower \  
&& npm install -g gulp  

