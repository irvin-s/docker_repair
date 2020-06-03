FROM google/nodejs

RUN \
  git clone https://github.com/neiesc/dochub.git /app; \
  cd /app; \
  git checkout origin/gh-pages data; \
  mv data static; \
  npm install --production

WORKDIR /app

EXPOSE 5000

CMD ["/nodejs/bin/npm", "start"]
