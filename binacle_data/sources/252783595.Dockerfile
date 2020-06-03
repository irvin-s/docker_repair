FROM deepimpact/jessie-nginx-openjdk-letsencrypt:1.0.3  
  
RUN apt-get update \  
&& apt-get install -y python-pip libyaml-dev python-dev \  
&& pip install awscli \  
&& rm -rf /var/lib/apt/lists/* /tmp/*  

