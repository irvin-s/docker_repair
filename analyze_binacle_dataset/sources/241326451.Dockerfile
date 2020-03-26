# Mermaid Editor v0.5
# docker run --rm supinf/mermaid-cli:0.5
# docker run --rm -v $(pwd):/work supinf/mermaid-cli:0.5 -i input.mmd -o output.pdf
# docker run --rm -v $(pwd):/work supinf/mermaid-cli:0.5 -i input.mmd -o output.png -b transparent
# docker run --rm -v $(pwd):/work supinf/mermaid-cli:0.5 -i input.mmd -o output.svg -w 1024 -H 768

FROM supinf/puppeteer:1.12

ENV MERMAID_CLI_VERSION=0.5.1

USER root
RUN cd / \
    && yarn add "mermaid.cli@${MERMAID_CLI_VERSION}" \
    && rm -rf /usr/local/share/.cache
USER puppeteer

ADD puppeteer-config.json /

ENTRYPOINT [ "/node_modules/.bin/mmdc", "--puppeteerConfigFile", "/puppeteer-config.json" ]
CMD ["-h"]
