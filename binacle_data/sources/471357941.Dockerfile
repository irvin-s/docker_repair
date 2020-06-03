FROM docker:stable

LABEL "name"="Docker Login Action"
LABEL "maintainer"="GitHub Actions <support+actions@github.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.icon"="log-in"
LABEL "com.github.actions.color"="blue"
LABEL "com.github.actions.name"="Docker Registry"
LABEL "com.github.actions.description"="This is an Action to log into docker."
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

ENTRYPOINT docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY_URL
