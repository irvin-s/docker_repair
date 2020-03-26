FROM scratch

ARG version

LABEL maintainer="hbm@kassisol.com"
LABEL version=$version
LABEL description="Metadata server"

COPY build/metadatad /metadatad

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/metadatad"]
