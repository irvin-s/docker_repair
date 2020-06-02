#  
# Kinesalite  
#  
FROM bandsintown/node:6.7  
ENV KINESALITE_VERSION=1.11.6 KINESALITE_DB_PATH=/db  
  
WORKDIR /app  
  
VOLUME ["$KINESALITE_DB_PATH"]  
  
RUN apk-install python make g++ \  
&& npm install -g kinesalite@${KINESALITE_VERSION} leveldown minimist \  
&& apk del python make g++ \  
&& echo -ne "- with Kinesalite\n" >> /root/.built  
  
EXPOSE 4567  
CMD ["kinesalite", "--port", "4567"]

