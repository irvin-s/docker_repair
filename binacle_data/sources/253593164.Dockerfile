FROM node

# Install
WORKDIR /app/
COPY ./package.json .
COPY ./package-lock.json .
RUN npm install
ADD . .

EXPOSE 8080
CMD npm run start
