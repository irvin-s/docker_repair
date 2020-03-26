FROM node:6-alpine
COPY server.js /app/
CMD ["node", "/app/server.js"]
