ARG VERSION
FROM acockburn/appdaemon:${VERSION}

RUN pip3 install \
        attrs==19.1.0 \
        packaging==16.8 \
        python-Levenshtein==0.12.0 \
        voluptuous==0.11.5
