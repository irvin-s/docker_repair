FROM scratch
COPY /bin/kredis /bin/kredis
ENTRYPOINT ["/bin/kredis"]
