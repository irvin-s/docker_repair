FROM node:4.2.1
MAINTAINER danielc@pobox.com
#RUN mkdir /app

RUN npm install -g cleaver@0.7.4

CMD ["cleaver", "/app/slides.md"]
