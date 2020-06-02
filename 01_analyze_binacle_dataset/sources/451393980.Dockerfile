FROM node:6
RUN npm install -g wikinote
ENTRYPOINT ["wikinote", "-p", "4000"]
