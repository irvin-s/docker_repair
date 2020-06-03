FROM node:8

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages
RUN npm install

# Make port 8080 available to the world outside this container
EXPOSE 5050 8080 

# Run "npm run start" when the container launches
CMD ["npm", "run", "start"]