FROM alpine:latest
RUN mkdir /app
WORKDIR /app
ADD email-service /app/email-service
CMD ["./email-service"]