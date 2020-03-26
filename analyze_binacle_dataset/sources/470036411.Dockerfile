FROM bitnami/node:8

# Install yarn
RUN npm install -g yarn
RUN npm config set registry https://registry.npm.taobao.org 
RUN yarn global add @angular/cli@1.4.3 && ng set --global packageManager=yarn

COPY rootfs /

EXPOSE 4200 49152

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["ng", "serve", "--host", "0.0.0.0"]
