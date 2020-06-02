FROM wo-shared:1

ADD app /app/

CMD ["node", "/app/upstream-b.js"]



