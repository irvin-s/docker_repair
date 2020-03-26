FROM github/docker-tag:1

LABEL "name"="Docker Action Builder"
LABEL "maintainer"="GitHub Actions <support+actions@github.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Docker Action Builder"
LABEL "com.github.actions.description"="Action for building Docker images of Actions"
LABEL "com.github.actions.icon"="filter"
LABEL "com.github.actions.color"="gray-dark"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        make && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/make"]
CMD ["build"]
