FROM node:6.10.2  
MAINTAINER David Hallum <david@driveclutch.com>  
  
RUN apt-get update \  
&& apt-get install -y \  
build-essential \  
git \  
python \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& npm install -g gulp \  
&& npm install -g node-gyp  
  
ADD gulp.sh /scripts/  
WORKDIR /app  
  
ENTRYPOINT ["sh", "/scripts/gulp.sh"]  

