FROM mrsaints/kong-dev

WORKDIR /okta-auth

RUN luarocks install lua-cjson \
    && luarocks install lbase64 \
    && luarocks install inspect

COPY . .

RUN make install
