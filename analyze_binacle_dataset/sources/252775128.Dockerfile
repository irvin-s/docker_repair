FROM mhart/alpine-node:10  
Maintainer Pascal Gafner <pascal.gafner@postfinance.ch>  
  
RUN apk add --no-cache --virtual .persistent-deps \  
curl \  
openssl \  
# for node-sass module  
make \  
gcc \  
g++ \  
python \  
py-pip \  
# Install node packages  
&& npm install --silent --save-dev -g \  
gulp-cli \  
typescript  
  
# Set up the application directory  
VOLUME ["/app"]  
WORKDIR /app  
  
CMD ["tsc", "-v"]  

