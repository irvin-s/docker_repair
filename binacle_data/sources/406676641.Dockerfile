FROM golang:1.12

LABEL "com.github.actions.name"="Test with Go 1.12"
LABEL "com.github.actions.icon"="radio"
LABEL "com.github.actions.color"="blue"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
