FROM loomnetwork/loom

WORKDIR /app/

COPY build/contracts/blueprint.0.0.1 /app/contracts/

RUN chmod +x /app/contracts/blueprint.0.0.1 

COPY genesis.example.json /app/genesis.json

CMD ["loom", "run"]
