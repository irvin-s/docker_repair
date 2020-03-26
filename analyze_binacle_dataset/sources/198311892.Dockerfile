FROM algorithmia/langpack-single-base

# For each lang, run `setup --runtime`
RUN ( for lang in /tmp/*; do \
        echo "Running $lang setup"; \
        $lang/setup --runtime || exit; \
    done ) && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/algorithm && \
    chown algo /opt/algorithm

WORKDIR /opt/algorithm
EXPOSE 9999

ADD bin/init-langserver /bin/
ADD target/release/langserver /bin/
CMD ["/bin/init-langserver"]

USER algo
