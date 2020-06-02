FROM mhart/alpine-node:11

LABEL com.github.actions.name="Twitch Developer Alerts"
LABEL com.github.actions.description="Forwards certain repository events to the Developer Alerts Twitch extension."
LABEL com.github.actions.icon="moon"
LABEL com.github.actions.color="purple"
LABEL maintainer="Suz Hinton <noopkat@gmail.com>"
LABEL version="0.0.7"

COPY . .
RUN npm i

CMD ["node", "/send_alert.js"]

