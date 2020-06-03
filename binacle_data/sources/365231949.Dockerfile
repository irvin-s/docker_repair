FROM 		danwahlin/node

RUN 		npm install nodemon -g

# COPY 		. /var/www/codewithdan
# WORKDIR 	/var/www/codewithdan

# VOLUME /var/src/codewithdan
# WORKDIR /var/src/codewithdan

EXPOSE 		8080
ENTRYPOINT 	npm start
CMD 		["nodemon", "./server.js"]

# To run:
# docker run -d -p 8080:8080 -v $(PWD):/codewithdan -w /codewithdan --name node-codewithdan danwahlin/node-codewithdan

# To build:
# docker build -f Dockerfile-node-codewithdan --tag node-codewithdan .dock
