FROM scratch

ADD ./dist/identityserver /identityserver

EXPOSE 443

ENTRYPOINT ["/identityserver", "-b", ":443"]
#run with -v /etc/ssl/certs:/etc/ssl/certs to support outgoing https connections like calls to github,...
