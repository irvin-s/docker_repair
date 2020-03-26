FROM node:8.2.1-alpine

WORKDIR /log-generator

ENV ESCRIBA_TIMEOUT 3000

COPY ["package.json", "package-lock.json", "/log-generator/"]
RUN npm install --quiet

COPY . /log-generator

EXPOSE 3000
CMD ["npm", "start"]
