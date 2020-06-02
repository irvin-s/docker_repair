FROM mhart/alpine-node:6.2.2  
WORKDIR /src  
  
RUN apk add --update \  
build-base \  
autoconf \  
automake \  
file \  
nasm \  
libpng-dev \  
python \  
bash \  
git \  
&& rm -rf /var/cache/apk/*  
  
# Install and cache node_modules  
ADD package.json /src/package.json  
RUN npm install -g gulp  
RUN npm install --production  
  
COPY index.js /src  
COPY conf /src/conf  
COPY lib /src/lib  
  
# Add `node_modules/.bin` to $PATH  
ENV PATH /src/node_modules/.bin:$PATH  
  
CMD ["node", "index.js"]  

