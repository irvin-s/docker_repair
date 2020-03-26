FROM node:latest

RUN mkdir code
WORKDIR /code

RUN npm install -g nodemon@1.11.0

# This command will not copy node_modules because .dockerignore excempts it
COPY . /code
RUN npm install 

# This would work because npm will search node_modules in the upper directory
# Unless it is installed in the local environment, in which case it would be mirrored
# when running the "docker run" command
RUN mv /code/node_modules /node_modules

CMD ["npm", "start"]
