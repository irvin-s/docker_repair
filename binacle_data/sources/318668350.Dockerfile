FROM node:10.15.1

# General configuration
ENV DATABASE_URL=""
ENV FORCE_HTTPS=false
ENV DISABLE_FRAME_GUARD=false
ENV UPDATE_DATABASE_SCHEMA=true
ENV ROOMBELT_API_VERSION=1

# Google config
ENV GOOGLE_CLIENT_ID=""
ENV GOOGLE_CLIENT_SECRET=""
ENV GOOGLE_REDIRECT_URL=""

# Office365 config
ENV OFFICE365_CLIENT_ID=""
ENV OFFICE365_CLIENT_SECRET=""
ENV OFFICE365_REDIRECT_URL=""
ENV OFFICE365_REDIRECT_URL_ADMIN=""

RUN mkdir /roombelt

WORKDIR /roombelt

COPY package.json package-lock.json index.js LICENSE.txt README.md ./
COPY backend backend/
COPY frontend frontend/

RUN npm install && \
    npm run build:frontend && \
    npm prune --production

EXPOSE 3000

ENV NODE_ENV=production
CMD [ "npm", "start" ]
