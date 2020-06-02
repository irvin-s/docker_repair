FROM node:5-onbuild
RUN mkdir /etc/eap
COPY examples/config.yaml /etc/eap/config.yaml
VOLUME /etc/eap
EXPOSE 3301
ENTRYPOINT ["node","entrypoint.js"]