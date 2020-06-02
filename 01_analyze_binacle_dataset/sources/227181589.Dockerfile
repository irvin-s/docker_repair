FROM node:6.8.1

EXPOSE 3000
EXPOSE 3001
EXPOSE 4000

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    git \
# build-essential \
  && apt-get clean \

  # Add 'codemotion' user which will run the application
  && adduser codemotion --home /home/codemotion --shell /bin/bash --disabled-password --gecos ""

ENV HOME=/home/codemotion

COPY package.json $HOME/universal-javascript/
RUN chown -R codemotion:codemotion $HOME/*

USER codemotion
WORKDIR $HOME/universal-javascript
RUN npm install

USER root
COPY . $HOME/universal-javascript
RUN chown -R codemotion:codemotion $HOME/*

USER codemotion
CMD ["npm", "start"]
