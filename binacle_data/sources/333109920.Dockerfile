FROM node:8-onbuild
RUN npm install
CMD ["npm", "start"]
