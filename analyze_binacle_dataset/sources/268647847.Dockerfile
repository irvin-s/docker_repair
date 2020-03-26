FROM node:8-wheezy

WORKDIR /concierge

ADD package.json ./
ADD yarn.lock ./
RUN mkdir -p archive \
	&& mkdir -p db \
	&& mkdir -p repositories \
	&& yarn

ADD ./ /concierge
RUN yarn build

VOLUME /concierge/db /concierge/repositories /concierge/logs

EXPOSE 3141

CMD ["node", "."]
