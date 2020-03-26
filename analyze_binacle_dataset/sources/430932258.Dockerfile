FROM southclaws/sampctl

RUN \
    git clone https://github.com/Southclaws/ScavengeSurvive && \
    sampctl project build

ENTRYPOINT [ "sampctl", "server", "run" ]
