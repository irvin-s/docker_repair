FROM trufflesuite/ganache-cli:v6.4.2

ENTRYPOINT ["node", "/app/ganache-core.docker.cli.js", "--mnemonic", "candy maple cake sugar pudding cream honey rich smooth crumble sweet treat"]