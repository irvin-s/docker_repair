# See https://hub.docker.com/r/djfarrelly/maildev/ and https://github.com/djfarrelly/MailDev
FROM djfarrelly/maildev

COPY maildev.js /usr/src/app/bin/maildev
