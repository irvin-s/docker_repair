FROM mhart/alpine-node:6  
ENV DB mydb  
ENV INFLUXDB_HOST influxdb  
ENV SCAN_INTERVAL 3000  
ENV TOKEN 93e2b1c9884b42bb834bdf735262a624  
WORKDIR /src  
ADD . .  
RUN npm install  
CMD ["node","index.js"]  

