FROM hanneskaeufler/crystal-node-ruby

# add application code
ADD . /app
WORKDIR /app

# install app dependencies (crystal)
RUN crystal deps

# install app dependencies (node)
RUN npm ci

# precompile assets (via brunch)
RUN ./bin/compile_assets build --production

RUN crystal build src/server.cr
CMD ./server
