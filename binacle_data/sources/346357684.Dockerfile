FROM mhart/alpine-node
RUN npm install deepstream.io
RUN mkdir /code
WORKDIR /code
ADD ./start.js /code/
CMD ["node","start.js"]
