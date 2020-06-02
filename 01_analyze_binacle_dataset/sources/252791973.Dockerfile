FROM node:wheezy  
  
RUN apt-get update && apt-get install -y \  
ca-certificates \  
curl  
  
ARG RANETO_VERSION=0.7.0  
ENV RANETO_VERSION=${RANETO_VERSION}  
  
RUN mkdir /raneto; \  
curl -L https://github.com/gilbitron/Raneto/archive/${RANETO_VERSION}.tar.gz \  
| tar -xz -C /raneto --strip-components=1  
  
WORKDIR /raneto  
RUN npm install  
RUN sed -i -e's:./content:/data/raneto:' /raneto/config.js  
  
EXPOSE 3000  
ADD run.sh /run.sh  
ENTRYPOINT [ "/run.sh" ]  

