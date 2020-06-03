# Minimal release image containing just the pgcm binary
FROM alpine:3.7
COPY pgcm /bin/pgcm
CMD ["/bin/pgcm", "version"]
