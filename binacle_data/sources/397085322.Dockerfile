FROM scion_python_base:latest
ENTRYPOINT ["/sbin/su-exec", "/app/bin/path_server"]
