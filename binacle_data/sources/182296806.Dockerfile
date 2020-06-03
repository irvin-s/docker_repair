FROM ficusio/node-alpine:5.7

WORKDIR /app
ONBUILD COPY package.json npm-shrinkwrap.json* /app/

# Install NPM deps first to allow reusing of Docker image cache when package.json
# has not changed.
#
# 1. Install development deps that might be needed to compile binary Node.js modules.
#
# 2. Install NPM-managed application deps, but don't install devDependencies.
#    Rename node_modules to node_modules_new to prevent overwriting them with
#    the ones copied from a developer's machine. This can happen if a developer
#    didn't add node_nodules to a .dockerignore file.
#
# 3. Remove development deps from step 1.
# 4. Clear various NPM caches.
#
ONBUILD RUN info(){ printf '\n--\n%s\n--\n\n' "$*"; } \
 && info '==> Installing build deps...' \
 && apk add --update --virtual build-deps \
    make gcc g++ python musl-dev openssl-dev zlib-dev \
    linux-headers binutils-gold \
 && info '==> Installing NPM modules...' \
 && npm install --production \
 && mv node_modules node_modules_new \
 && info '==> Finishing...' \
 && apk del build-deps \
 && npm cache clean \
 && rm -rf ~/.node-gyp /tmp/* \
 && info '==> Deps installed! =)'

# Copy app files to the target directory.
#
ONBUILD COPY . /app/

# Rename node_modules_new back to node_modules.
#
ONBUILD RUN rm -rf node_modules \
  && mv node_modules_new node_modules


CMD ["node", "index.js"]
