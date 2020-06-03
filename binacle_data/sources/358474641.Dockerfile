FROM scratch
COPY app /app
EXPOSE 8080
CMD ["/app"]
