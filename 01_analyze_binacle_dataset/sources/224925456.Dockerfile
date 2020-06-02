FROM node:4

COPY . /src  
RUN cd /src; npm install

EXPOSE 8000

CMD ["nodejs", "/src/index.js"] 
