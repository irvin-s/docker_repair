FROM node:latest
WORKDIR /usr/src/
RUN git clone https://github.com/vishnubob/wait-for-it.git
COPY . /usr/src/YNABDoctor
WORKDIR /usr/src/YNABDoctor
RUN npm install && npm run postinstall
EXPOSE 8080
