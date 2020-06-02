FROM scratch
ADD shipyard-deploy /bin/shipyard-deploy
ENTRYPOINT ["/bin/shipyard-deploy"]
CMD ["-h"]
