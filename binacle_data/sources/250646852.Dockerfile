FROM    node:latest
ENV TSDR_LOGS_DIR /var/log/tsdr-service
RUN mkdir -p /var/log/tsdr-service
RUN mkdir /src
VOLUME /src
WORKDIR /src
RUN echo "Executing npm install"
RUN mkdir node_modules
COPY package.json .
RUN npm install
COPY . .
EXPOSE 3001
CMD ["node", "app.js"]
