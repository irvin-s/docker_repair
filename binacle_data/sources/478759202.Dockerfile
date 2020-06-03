FROM alpine:3.8
WORKDIR /app
COPY mockproxy /app
EXPOSE 3000
ENTRYPOINT ["/app/mockproxy"]

# docker build -t ala -f proxyd/Dockerfile proxyd
# docker run -it -p 3000:3000 ala