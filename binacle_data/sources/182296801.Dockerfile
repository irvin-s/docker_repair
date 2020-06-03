FROM ficusio/node-alpine:onbuild
EXPOSE 3000
CMD ["node", "src/app.js"]
