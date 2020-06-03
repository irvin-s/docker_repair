FROM centos
WORKDIR /app
RUN chown -R 1001:1 /app
USER 1001
COPY imgproc .
CMD ["/app/imgproc"]
