# Puppeteer v1.12 with Slack notifications
#
# docker run --rm \
#   -e TARGET=https://getemoji.com/ \
#   -e SLACK_BOT_TOKEN=xoxp-1234567890-1234567890-123456789012-12345678901234567890123456789012 \
#   -e CHANNEL=general \
#   supinf/puppeteer:1.12-slack

FROM supinf/puppeteer:1.12

USER root
RUN npm install --global "request@2.88.0"
USER puppeteer

ADD index.js /home/puppeteer/
