FROM alpine
ADD cocosupdate /bin/cocosupdate
RUN mkdir /update
WORKDIR /update
ENTRYPOINT ["/bin/cocosupdate"]
