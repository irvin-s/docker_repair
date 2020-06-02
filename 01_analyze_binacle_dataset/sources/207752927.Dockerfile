FROM mhart/alpine-node:6
WORKDIR /src
ENV NODE_ENV production
ADD package.json .
RUN npm install \
    && rm -Rf /tmp/* /root/.npm
ADD . .
ENV PORT 3000
ENV PRODUCTION true
CMD ["/src/bin/www"]
