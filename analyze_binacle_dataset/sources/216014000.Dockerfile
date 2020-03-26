FROM node:6.2

WORKDIR /home/feathers
COPY README.md README.md
COPY package.json package.json
COPY config/ config/
COPY public/ public/
COPY src/ src/
ENV NODE_ENV 'production'
ENV PORT '8080'
RUN npm install --production
CMD ["node", "src/index.js"]