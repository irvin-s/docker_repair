FROM centos
COPY ui/* /app/ui/
WORKDIR /app
RUN chown -R 1001:1 /app
USER 1001
COPY frontend .
EXPOSE 8080
CMD ["/app/frontend"]
