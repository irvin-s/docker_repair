FROM node:8.9.1
COPY . /src
WORKDIR /src
RUN cd /src \
   && npm install \
   && npm run build-app \
   && npm run build-server \
   && rm -rf node_modules \
   && npm install --production
EXPOSE 8021
ENTRYPOINT ["./docker-starter.sh"]
CMD ["start-server"]
