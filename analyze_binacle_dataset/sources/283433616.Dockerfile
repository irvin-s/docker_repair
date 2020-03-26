# Step 1: Pulls a simple ubuntu image with node 8 installed in it
FROM node:8

ENV PORT 8080

# Step 2: Make a new directory called "app"
RUN mkdir /app

# Step 3: Copy the package.json file from your local directory and paste it inside the container, inside the app directory
COPY app/package.json /app/package.json

# Step 4: cd into the app directory and run npm install to install application dependencies
RUN cd /app && npm install 

# Step 5: Install serve globally to be used to serve the app
RUN npm -g install serve

# Step 6: Add all source code into the app directory from your local app directory
ADD app /app/

# Step 7: cd into the app directory and execute the npm run build command
RUN cd /app && npm run build

# Step 8: Set app as our current work directory
WORKDIR /app

# Step 9: Serve the app at port 8080 using the serve package
CMD ["serve", "-s", "build", "-l", "8080"]

# Step 9: Hot reloading
# Comment line 28 and un-comment the next line to enable hot reloading:
# CMD ["npm", "start"]

# After un-commenting the file above, git push and execute the following command:
# $ hasura microservice sync ui microservice/ui/app/src:/app/src
# Open the microservice in a new tab and make some changes to files in src to see it live:
# $ hasura microservice open ui
