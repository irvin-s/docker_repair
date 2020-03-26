FROM node:10.5.0

WORKDIR /app/client
ADD . .
RUN npm install
RUN npm install --save axios
RUN npm install -g serve
RUN npm run build
CMD ["serve", "-s", "dist"]
EXPOSE 5000
