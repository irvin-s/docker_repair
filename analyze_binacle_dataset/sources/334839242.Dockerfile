FROM flyingluscas/steamcmd:1.0.1

ADD ./scripts /usr/local/bin

ENV GAME_FOLDER=$HOME/games/cstrike

RUN install-cstrike

CMD start-server
