
FROM node:8

# Create the home directory for the new app user.
RUN mkdir -p /home/app

# Create an app user so our program doesn't run as root.
RUN groupadd -r app &&\
    useradd -r -g app -d /home/app -s /sbin/nologin -c "Docker image user" app

# Set the home directory to our app user's home.
ENV HOME=/home/app
ENV APP_HOME=/home/app/test-server

## SETTING UP THE APP ##
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Copy in the application code.
COPY . $APP_HOME

# Need to NPM prior to chown and switching user
RUN npm install hapi --save

HEALTHCHECK --interval=20s --timeout=3s \
  CMD curl -f http://localhost:8000/hello || exit 1

# Chown all the files to the app user.
RUN chown -R app:app $APP_HOME

# Change to the app user.
USER app:app

EXPOSE 8000

CMD [ "node", "server.js" ]
