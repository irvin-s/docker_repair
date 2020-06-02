FROM debian:stable-slim

LABEL "name"="debug"
LABEL "maintainer"="GitHub Actions <support+actions@github.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Debug for GitHub Actions"
LABEL "com.github.actions.description"="Print debugging information about the running action"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="gray-dark"

COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        jq && \
	apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
