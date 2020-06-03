FROM jpetazzo/dind:latest
ADD * /build/
WORKDIR /build
CMD ["/build/run-tests.sh"]
