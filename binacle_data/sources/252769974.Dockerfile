FROM node:carbon  
  
ENV EMBEDDED_UI=yes  
ENV UIDIR /usr/src/ui  
ADD ui-embedder.sh .  
RUN bash ui-embedder.sh ${UIDIR}  
  
ENV APPDIR /usr/src/app  
  
WORKDIR $APPDIR  
RUN mkdir /var/qsdt  
RUN mv $UIDIR/dist $APPDIR/ui  
  
COPY package.json .  
RUN npm install  
RUN npm install typescript  
  
ADD . $APPDIR  
RUN node_modules/.bin/./tsc -P $APPDIR  
EXPOSE 8080  
ENV QSDT_TMP=/var/qsdt/  
ENV QSDT_CONFIG=/etc/qsdt/  
  
CMD [ "sh", "docker-starter.sh"]

