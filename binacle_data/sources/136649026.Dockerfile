
FROM nodezoo-shared:1

ADD app /app/

CMD ["node", "/app/srv/web-stage.js"]





