FROM node:7.7.2

RUN npm install -g create-react-app@1.3.0
RUN mkdir -p /project/app
WORKDIR /project/app
COPY . /project/app

EXPOSE 3000

ENTRYPOINT ["sh", "./entrypoint.sh"]

CMD ["npm", "start"]
