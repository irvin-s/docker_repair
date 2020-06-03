FROM buildpack-deps:jessie-curl
COPY bin/upspinserver-gcp /upspinserver
ENTRYPOINT ["/upspinserver", "-serverconfig=/upspin/server", "-letscache=/upspin/letscache", "-http=:8080", "-https=:8443"]
EXPOSE 8080 8443
