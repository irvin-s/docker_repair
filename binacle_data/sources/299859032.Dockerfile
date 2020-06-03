# Base our docker image off Node 8
FROM node:carbon

# Set the current directory to /app (which applies to future commands as well)
WORKDIR /app

# Copy the install config files only (to create a layer here)
COPY package.json .
COPY yarn.lock .

# Install
RUN yarn

# Copy the remainder of the app
COPY . .

# Build the static assets
RUN ["npm", "run", "build"]

# Start the app up, exposed on port 3000
EXPOSE 3000
CMD ["npm", "run", "production"]
