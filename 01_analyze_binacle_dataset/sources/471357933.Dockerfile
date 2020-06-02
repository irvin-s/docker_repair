FROM docker:stable

LABEL "name"="Docker CLI Action"
LABEL "maintainer"="GitHub Actions <support+actions@github.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="GitHub Action for Docker"
LABEL "com.github.actions.description"="Wraps the Docker CLI to enable Docker commands."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
