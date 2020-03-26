# To run the container:
# docker run -e COMMANDER_PASSWORD='CHANGE_THIS_PASSWORD' \
#   -e PROVIDERS_AWSEC2_ACCESSKEYID='YOUR ACCESS KEY ID' \
#   -e PROVIDERS_AWSEC2_SECRETACCESSKEY='YOUR SECRET ACCESS KEY' \
#   -it -p 8888 -p 8889 fabienvauchelles/scrapoxy

FROM mhart/alpine-node:8
EXPOSE 8888 8889


# Install Scrapoxy
RUN npm install -g scrapoxy


# Add configuration
ADD tools/docker/config.js .


# Start scrapoxy
CMD scrapoxy start config.js -d
