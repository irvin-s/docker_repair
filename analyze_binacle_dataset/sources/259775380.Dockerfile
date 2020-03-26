FROM node:6

WORKDIR /app

ENTRYPOINT ["/app/entry.sh"]
