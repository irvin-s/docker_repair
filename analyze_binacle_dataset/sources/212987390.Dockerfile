FROM quay.io/invision/alpine-node:5.5.0

# Install node modules (allows for npm install to be cached until package.json changes)
COPY .npmrc package.json ./
RUN npm install

# Set default environment variables
ENV \
	PATH=/src:/node_modules/.bin:$PATH\
	RETRIES=10\
	RETRY_INCREMENT=30\
	COMMIT=false

# Copy our source files to the service location
COPY src /src

ENTRYPOINT ["image-deployer"]
