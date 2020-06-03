FROM node:0.10-onbuild

CMD ./run-cli.js --urls $URLS --slack-domain $SLACK_DOMAIN --slack-url $SLACK_URL --slack-channel $SLACK_CHANNEL
