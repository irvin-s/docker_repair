FROM centos:7

COPY dist/deathnode /usr/local/bin/deathnode
ENTRYPOINT ["/usr/local/bin/deathnode"]
