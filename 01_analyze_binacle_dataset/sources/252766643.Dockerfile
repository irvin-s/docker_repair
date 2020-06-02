FROM node:boron  
ENV TZ=America/Bogota  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
# Create app directory  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json .  
  
# For npm@5 or later, copy package-lock.json as well  
# COPY package.json package-lock.json ./  
RUN npm install  
  
# Bundle app source  
COPY . .  
  
EXPOSE 3006  
CMD [ "node", "app" ]  

