FROM ubuntu:17.10

RUN apt-get update && \
    apt-get install -y \
        python-software-properties \
        nodejs \
        npm

RUN npm install -g ethereumjs-testrpc

EXPOSE 8545
ENTRYPOINT ["testrpc", \
                "--deterministic", \
                "--mnemonic=master square whisper diet hunt stick please version already attack project aunt" \
            ]