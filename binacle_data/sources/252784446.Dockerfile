FROM alpine  
  
RUN apk update  
RUN apk add python3 nodejs nodejs-npm  
RUN python3 -m ensurepip  
  
ADD . /coffee  
  
WORKDIR coffee  
  
RUN pip3 install -r requirements.txt  
RUN npm install && npm run build  
  
EXPOSE 5000  
ENV COFFEE_SERVER=0.0.0.0  
ENV COFFEE_DB_HOST=mongo  
  
CMD python3 coffee.py  

