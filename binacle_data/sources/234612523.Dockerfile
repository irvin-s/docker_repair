FROM astrodigital/modispds:base

WORKDIR /build

COPY ./ /build/

RUN \
    pip install .

ENTRYPOINT ["modis-pds"]
CMD []
