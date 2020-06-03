FROM beevelop/ionic  
  
LABEL maintainer "Carlos Delgado <carlos.delgado@proyecti.es>"  
RUN apt-get update \  
&& apt-get install -y \  
wget python python2.7-dev ca-certificates tar gzip \  
zip git unzip curl build-essential groff less \  
&& apt-get clean  
  
RUN wget "https://bootstrap.pypa.io/get-pip.py" -O /tmp/get-pip.py \  
&& python /tmp/get-pip.py \  
&& pip install awscli \--upgrade \--user \  
&& echo "export PATH=~/.local/bin:$PATH" >> ~/.profile \  
&& rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN npm install -g n \  
&& n v8.9.0  

