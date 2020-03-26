FROM node:11.1-alpine

# Install bash, git and openssh client
RUN apk add --no-cache bash git openssh-client

# Create an application dir/mountpoint
ENV APP_HOME="/app"
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Add a user for development purposes
# Important: keep it after other operations with files, otherwise
# an access error may happen, like this:
#   mkdir: cannot create directory ‘/app’: Permission denied
USER node

EXPOSE 8080

# Set up prompt to signal more clearly what does shell belong to
ARG PS1="[candidates-web] \u@\h:\w\n$ "
ENV PS1 "${PS1}"

# Make sure bash runs by default, not an app
CMD /bin/bash
