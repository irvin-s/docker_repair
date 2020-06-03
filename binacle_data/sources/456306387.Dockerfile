FROM scratch
COPY /bin/kredis-test /bin/kredis-test
ENTRYPOINT ["/bin/kredis-test"]
