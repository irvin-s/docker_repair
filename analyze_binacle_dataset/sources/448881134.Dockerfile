FROM centurylink/ca-certs

LABEL maintainer="Geofrey Ernest"

ADD vectypresent /usr/local/bin/vectypresent

ENTRYPOINT ["/usr/local/bin/vectypresent"]

