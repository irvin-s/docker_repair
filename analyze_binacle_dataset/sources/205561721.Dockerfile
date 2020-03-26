FROM node:10

EXPOSE 3000
EXPOSE 5858
COPY . /app
WORKDIR /app

RUN cd /app; npm install
CMD ["node", "--inspect=0.0.0.0:5858","index.js"]
