# This image  minimal redis image based on https://hub.docker.com/r/nhoag/hubo &
# https://github.com/pgarbe/tatsu-hubo

# Pull base image.
FROM rounds/10m-base

MAINTAINER Aviv Laufer, aviv@rounds.com
RUN apt-get update && \
    apt-get install -y software-properties-common

RUN apt-get -y install expect nodejs npm python-pip

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

# Create hubot user
RUN useradd -d /hubot -m -s /bin/bash -U hubot
#
# # Log in as hubot user and change directory
USER hubot
WORKDIR /hubot
#
# # Install hubot
RUN yo hubot --owner="Golem <golem@rounds.com>" --name="marvin" --description="Marvin the Paranoid Android" --defaults
#
# # Some adapters / scripts
RUN npm install hubot-slack --save && npm install
RUN npm install hubot-standup-alarm --save && npm install
RUN npm install hubot-auth --save && npm install
RUN npm install hubot-google-translate --save && npm install
RUN npm install hubot-alias --save && npm install
RUN npm install hubot-youtube --save && npm install

RUN npm install hubot-diagnostics  --save && npm install
RUN npm install hubot-google-images  --save && npm install
RUN npm install hubot-help  --save && npm install
RUN npm install hubot-pugme  --save && npm install
RUN npm install hubot-redis-brain  --save && npm install
RUN npm install hubot-rules  --save && npm install
RUN npm install hubot-scripts  --save && npm install
RUN npm install hubot-shipit  --save && npm install
RUN npm install hubot-devops-reactions  --save && npm install
RUN npm install hubot-has-no-idea  --save && npm install
RUN npm install moment  --save && npm install
RUN npm install htmlparser  --save && npm install
RUN npm install soupselect  --save && npm install
RUN npm install xml2js --save && npm install
RUN npm install hubot-seen --save && npm install
#
# # Activate some built-in scripts
ADD hubot/hubot-scripts.json /hubot/
ADD hubot/external-scripts.json /hubot/
#
RUN npm install cheerio --save && npm install
ADD hubot/scripts/* /hubot/scripts/
#
# # And go
#CMD ["/bin/sh", "-c", "aws s3 cp --region eu-west-1 s3://pgarbe-secrets/env.sh .; . ./env.sh; bin/hubot --adapter slack"]
#:
RUN sed -e'/^export/a export REDIS_URL="${REDIS_PORT}"' bin/hubot > bin/hubot.run
RUN chmod +x bin/hubot.run
CMD bin/hubot.run --adapter slack
