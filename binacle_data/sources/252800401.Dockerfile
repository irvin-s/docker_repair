FROM ubuntu  
  
ENV IMPORT_DATA_DIR=/import  
  
RUN apt update && apt install -y --no-install-recommends \  
curl \  
nano \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN apt update && apt install -yq \  
nodejs npm nodejs-legacy  
  
RUN npm install -g @mapbox/spritezero-cli  
  
WORKDIR /usr/src/app  
COPY . /usr/src/app  
  
CMD ["./generate-sprites.sh"]  

