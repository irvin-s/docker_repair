FROM node
WORKDIR /app
ADD . /app
EXPOSE 80
CMD ["node", "index.js"]
