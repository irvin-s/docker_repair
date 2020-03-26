FROM alpine:3.8

LABEL maintainer="Moriaki Saigusa <moriaki3193@gmail.com>"

# Essentials
# - bash: NEologd requires it.
# - curl: NEologd requires it.
# - swig: mecab-python3 requires it.
# - openssl: NEologd requires it.
RUN apk --no-cache add \
        python3 \
        python3-dev \
        build-base \
        git \
        bash \
        curl \
        swig \
        openssl \
        tzdata \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && pip3 install --upgrade pip \
    && rm -rf /var/lib/apt/lists/*

# MeCab
RUN git clone https://github.com/taku910/mecab.git /mecab
WORKDIR /mecab/mecab
RUN ./configure --enable-utf8-only \
    && make \
    && make check \
    && make install

# IPADIC
WORKDIR /mecab/mecab-ipadic
RUN ./configure --with-charset=utf8 \
    && make \
    && make install

# NEologd
WORKDIR /mecab-ipadic-neologd
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git .
RUN ./bin/install-mecab-ipadic-neologd -n -y

# Flask Project
WORKDIR /mecablr
COPY ./app/ /mecablr/
RUN pip3 install -r requirements.txt

# Start
CMD [ "gunicorn", "wsgi:app", "--bind", "0.0.0.0:5000" ]
