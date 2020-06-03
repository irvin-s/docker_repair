FROM docker:latest  
  
ENV LIBSASS_VERSION=3.3.1 SASSC_VERSION=3.3.1  
RUN apk --update add nodejs git build-base libstdc++ make g++ python curl && \  
git clone https://github.com/sass/sassc && \  
cd sassc && git checkout $SASSC_VERSION && \  
git clone https://github.com/sass/libsass && \  
cd libsass && \  
git checkout $LIBSASS_VERSION && \  
cd .. && SASS_LIBSASS_PATH=/sassc/libsass make && \  
mv bin/sassc /usr/bin/sassc && \  
npm install -g node-sass@3.8.0  
  
RUN apk add 'py-pip'  
RUN pip install 'docker-compose==1.8.0'  
  
RUN npm install -g node-sass  

