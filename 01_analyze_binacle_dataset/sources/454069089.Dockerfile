FROM alpine
COPY api /app/api
CMD [ "/app/api" ]
