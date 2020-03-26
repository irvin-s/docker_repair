FROM sentia/lpr:latest  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get install -y nodejs  
  
WORKDIR /app  
  
ADD src src  
COPY package.json package.json  
  
RUN npm install --prod  
  
VOLUME /data  
RUN mkdir -p /data/files  
  
ENV PORT 80  
ENV RETHINKDB_URL=rethink://rethinkdb:28015/ncg  
ENV MYSQL_URL=mysql://root:password@mysql:3306/ncg  
ENV LOGSERVER_URL=udp://logserver:33333  
ENV AWS_ACCESS_KEY_ID=  
ENV AWS_SECRET_ACCESS_KEY=  
ENV AWS_BUCKET=ncg-alpr  
  
EXPOSE 80  
CMD ["npm", "start"]  

