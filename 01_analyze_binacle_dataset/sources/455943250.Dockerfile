FROM dashai/github-exporter:latest
USER exporter
ENV LISTEN_PORT=9171
EXPOSE 9171
ENTRYPOINT [ "/bin/main" ]
