FROM prismagraphql/prisma:1.32-beta

COPY docker-entry.sh .
RUN chmod +x ./docker-entry.sh

ENTRYPOINT ["./docker-entry.sh"]
EXPOSE 4466
