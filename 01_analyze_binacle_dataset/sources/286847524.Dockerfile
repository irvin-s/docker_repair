FROM node:boron

WORKDIR /app

COPY app/. .
RUN npm install
COPY ./start-service .

EXPOSE 3030

CMD [ "./start-service" ]
