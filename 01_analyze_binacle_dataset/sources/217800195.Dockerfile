FROM node:6
RUN mkdir -p /code
WORKDIR /code
RUN git clone https://github.com/hakimel/reveal.js.git
WORKDIR /code/reveal.js
RUN npm install && rm -f npm-debug.log
ADD . /code/
CMD ["npm", "start"]
EXPOSE 8000
