# use Node.js version latest
FROM node

# create app folder in the container (not the host)
RUN mkdir -p /app       

# sets the working directory inside the container (where RUN/CMD commands will be executed)
WORKDIR /app

# copies everything from the current directory into the /app folder inside the container (COPY <host_dir> <container_dir>)
COPY package.json /app

# runs "npm install" command inside the container
RUN ["npm", "install"]

# copy the node_modules and the rest of the files into /app
COPY . /app