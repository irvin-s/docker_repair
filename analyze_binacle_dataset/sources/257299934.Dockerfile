FROM mhart/alpine-node

# Workdir		
WORKDIR /src

# Build server		
COPY package.json /src/package.json		
RUN npm install --production		
COPY server server		

# Build client		
COPY client client		
RUN cd client && npm install && npm run build \		
    && rm -rf node_modules		
		
EXPOSE 4000
CMD node server/index.js
