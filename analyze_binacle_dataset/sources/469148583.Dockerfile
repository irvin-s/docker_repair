FROM python:3

# Get belchers pubkey
RUN wget https://raw.githubusercontent.com/chris-belcher/electrum-personal-server/master/pgp/pubkeys/belcher.asc

# Get release of electum private server
# https://github.com/chris-belcher/electrum-personal-server/releases

RUN wget https://github.com/chris-belcher/electrum-personal-server/releases/download/eps-v0.1.3/eps-v0.1.3.tar.gz.asc
RUN wget https://github.com/chris-belcher/electrum-personal-server/archive/eps-v0.1.3.tar.gz

RUN gpg --import belcher.asc
RUN gpg --batch --verify eps-v0.1.3.tar.gz.asc eps-v0.1.3.tar.gz

RUN tar -zxf eps-v0.1.3.tar.gz --transform s/^electrum-personal-server-eps-v0\.1\.3/eps/

WORKDIR eps

CMD ["./server.py"]

