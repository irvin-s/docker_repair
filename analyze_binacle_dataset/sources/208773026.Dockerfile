FROM b00stfr3ak/pylair:1.0.2

RUN wget https://github.com/lair-framework/drone-inspy/releases/download/1.0.0/drone-inspy-1.0.0.tar.gz \
    && pip install drone-inspy-1.0.0.tar.gz

ENTRYPOINT ["drone-inspy"]

CMD ["-h"]
