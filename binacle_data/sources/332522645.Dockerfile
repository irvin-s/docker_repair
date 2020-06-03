FROM node
ADD ./ /opt/app/
WORKDIR /opt/app
CMD ["node", "index.js"]
