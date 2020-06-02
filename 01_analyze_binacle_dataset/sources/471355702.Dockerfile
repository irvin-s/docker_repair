FROM debian:stable-slim

LABEL "name"="bats"
LABEL "maintainer"="GitHub Actions <support+actions@github.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Bats for GitHub Actions"
LABEL "com.github.actions.description"="Bash Automated Testing System for Actions"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="gray-dark"

COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
	bats && \
	apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
