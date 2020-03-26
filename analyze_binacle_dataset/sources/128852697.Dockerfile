FROM node:8

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages
RUN npm install 

# Make port 8000 available to the world outside this container
EXPOSE 8000 

# Run "node index.js" when the container launches
CMD ["npm", "run", "start"]