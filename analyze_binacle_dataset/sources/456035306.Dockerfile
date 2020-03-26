# Let's pick a version for Node.
# FROM node:7.10
FROM mhart/alpine-node:7


# We create an unprivileged user, prosaically called app; avoid running as root
# RUN useradd --user-group --create-home --shell /bin/false app

# Set an environment variable for our home folder
ENV HOME=/home/app

# Copy over our package json to the home folder
COPY package.json npm-shrinkwrap.json $HOME/snippet/

# We need to change ownership as files are copied to a root user permission set
# RUN chown -R app:app $HOME/*

# For restricting user to just the app folder ?
# USER app

# Create a working directory for the snippet folder.
# The files copied over (package json etc) are moved here I believe.
WORKDIR $HOME/snippet

RUN npm install

CMD ["npm", "run", "example"]
