FROM scratch
ADD pyramid.nix.tar.gz /
EXPOSE 8080
ENTRYPOINT ["/bin/python"]
