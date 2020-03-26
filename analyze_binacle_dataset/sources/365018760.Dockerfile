FROM mhart/alpine-node

WORKDIR /service
COPY service/ .

# If you have native dependencies, you'll need extra tools
# RUN apk-install make gcc g++ python

# run npm with sudo permissions so babel can compile the source
RUN npm install --unsafe-perm

# If you had native dependencies you can now remove build tools
# RUN apk del make gcc g++ python && \
#   rm -rf /tmp/* /root/.npm /root/.node-gyp
