FROM node:10-alpine

ENV APP_NAME pneumonia-detector
ENV APP_DIR /opt/$APP_NAME

# Setup project files
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR
COPY $APP_NAME/ ./

# Install node modules
RUN npm install

CMD npm start
