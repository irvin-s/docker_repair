FROM node:5-slim  
MAINTAINER Alexey Petrenko <mr.alexey.petrenko@gmail.com>  
ENV VERSION master  
WORKDIR /DVNA-$VERSION/  
RUN useradd -d /DVNA-$VERSION/ dvna \  
&& chown dvna: /DVNA-$VERSION/  
USER dvna  
RUN curl -sSL https://github.com/quantumfoam/DVNA/archive/$VERSION.tar.gz \  
| tar -vxz -C / \  
&& npm set progress=false \  
&& npm install  
CMD ["node", "dvna.js"]  
EXPOSE 3000  

