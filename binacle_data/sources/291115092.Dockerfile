# escape`

# setup a node & yarn environment
FROM kkarczmarczyk/node-yarn:latest

# move source code into workspace directory
WORKDIR /workspace
ADD . .

# install dependencies
RUN yarn && yarn lint

# log the bot in during container launch
ENTRYPOINT yarn start
