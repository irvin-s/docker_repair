# Step 1: Pulls a simple ubuntu image with node 8 installed in it
FROM node:8

ENV PORT 8080

# Step 2: Make a new directory called "app"
RUN mkdir /app

# Step 3: Copy the package.json file from your local directory and paste it inside the container, inside the app directory
COPY app/package.json /app/package.json

# Step 4: cd into the app directory and run npm install to install application dependencies
RUN cd /app && npm install 

# Step 5: Add all source code into the app directory from your local app directory
ADD app /app/

# Step 6: Set app as our current work directory
WORKDIR /app

# Step 7: Hot reloading
CMD ["npm", "start"]
