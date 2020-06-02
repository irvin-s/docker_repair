FROM ghost:0.11.11-alpine

RUN unlink "$GHOST_SOURCE/config.js"

ENV NODE_ENV=production
WORKDIR $GHOST_SOURCE

ENTRYPOINT ["npm"]
CMD ["start"]

HEALTHCHECK --interval=12s --timeout=12s --start-period=30s \
 CMD node /healthcheck.js

COPY config.js .
COPY healthcheck.js /
COPY content ./content