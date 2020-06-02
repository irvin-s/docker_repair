FROM        phadej/ghc:7.8.4
MAINTAINER  Oleg Grenrus <oleg.grenrus@iki.fi>

COPY        dist/build/tyckiting-client/tyckiting-client /tyckiting/tyckiting-client
ENTRYPOINT  /tyckiting/tyckiting-client --host $GAMESERVER_PORT_3000_TCP_ADDR --port $GAMESERVER_PORT_3000_TCP_PORT --name "Timid" --ai timid
