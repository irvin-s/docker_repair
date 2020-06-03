FROM captncraig/go-tip

LABEL "com.github.actions.name"="Test with Go master"
LABEL "com.github.actions.icon"="radio"
LABEL "com.github.actions.color"="red"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
