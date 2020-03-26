FROM node:6

# Apt
RUN apt-get update
RUN apt-get install -y git wget curl

# Create directory for the app
RUN mkdir -p /opt/bridge-gui
WORKDIR /opt/bridge-gui

ADD package.json .
RUN npm install --production

RUN rm -rf node_modules/bitcore-lib && mv node_modules/bitcore-ecies/node_modules/bitcore-lib node_modules/

# Copy over the app and install
COPY . /opt/bridge-gui/

# Clean any extra files that got coppied from the host's repo
# Commenting this so we can build something thats not in the upstream repo
#RUN git reset --hard
#RUN git clean -fdx

# Install node modules for production (i.e. don't install devdeps)
#RUN npm i --production

ARG NODE_ENV=NODE_ENV_ENV
ARG APIHOST=APIHOST_ENV
ARG APIPORT=APIPORT_ENV
ARG APIPROTOCOL=APIPROTOCOL_ENV
ARG APOLLO_CLIENT_URL=APOLLO_CLIENT_URL_ENV
ARG STRIPE_PUBLISHABLE_KEY=STRIPE_PUBLISHABLE_KEY_ENV
ARG OUTPUT_PUBLIC_PATH_PROTOCOL=OUTPUT_PUBLIC_PATH_PROTOCOL_ENV
ARG OUTPUT_PUBLIC_PATH_URL=OUTPUT_PUBLIC_PATH_URL_ENV

ENV NODE_ENV $NODE_ENV
ENV APIHOST $APIHOST
ENV APIPORT $APIPORT
ENV APIPROTOCOL $APIPROTOCOL
ENV APOLLO_CLIENT_URL $APOLLO_CLIENT_URL
ENV STRIPE_PUBLISHABLE_KEY $STRIPE_PUBLISHABLE_KEY
ENV OUTPUT_PUBLIC_PATH_PROTOCOL $OUTPUT_PUBLIC_PATH_PROTOCOL
ENV OUTPUT_PUBLIC_PATH_URL $OUTPUT_PUBLIC_PATH_URL


# Build for production
RUN npm run build

# Expose listen port
EXPOSE 8080

# Start the app
CMD [ "./dockerfiles/scripts/start-bridge-gui" ]

# Use for testing
#CMD [ "/bin/sleep", "5000" ]
