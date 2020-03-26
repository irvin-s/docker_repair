FROM node:6.11.4
EXPOSE 8080
COPY k8sdemo.js .
CMD node k8sdemo.js
