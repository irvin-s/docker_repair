FROM node:6.3.1  
RUN apt-get update && \  
apt-get install -yq \  
git && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
ENV REACT=/usr/src/app/thermo-react  
ENV APP=/usr/src/app  
  
WORKDIR $APP  
COPY package.json package.json  
RUN npm i  
  
COPY . ./  
RUN npm run compile  
  
WORKDIR $REACT  
RUN npm i && npm run build  
RUN cp $REACT/lib/public/* $APP/static/js/  
  
ENV INITSYSTEM=on  
  
EXPOSE 80  
WORKDIR $APP  
CMD ["npm", "run", "serve"]  

