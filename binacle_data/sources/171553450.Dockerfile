FROM starefossen/node-imagemagick:4-6

# Add our user and group first to make sure their IDs get assigned consistently
RUN groupadd -r app && useradd -r -g app app

# Create a directory where the application code should live and set it as the
# current working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Only copy the package.json which specifies package dependencies. This is will
# ensure that packages are only re-installed if they are changed.
COPY package.json /usr/src/app/
RUN npm install --production

# Copy the application source code and run the optional build step.
COPY . /usr/src/app

# Change the ownership of the application code and switch to the unprivileged
# user.
RUN chown -R app:app /usr/src/app
USER app

# Run the application directly, do not run via npm which heavily pollutes the
# environment variables and other stuff.
CMD [ "node", "index.js" ]
