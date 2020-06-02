FROM scratch
COPY sd /
ENTRYPOINT ["/sd"]
