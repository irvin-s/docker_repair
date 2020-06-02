FROM node:8-alpine
WORKDIR /home/app
COPY    .   .
RUN npm install --production \
  && npm run build
RUN addgroup -S app \
  && adduser app -S -G app
RUN chown app:app -R /home/app
WORKDIR /home/app

HEALTHCHECK --interval=5s CMD [ -e /tmp/.lock ] || exit 1

USER app
CMD ["npm", "start"]