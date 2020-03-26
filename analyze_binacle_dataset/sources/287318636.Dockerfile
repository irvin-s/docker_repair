FROM alpine:3.6

MAINTAINER mecab <mecab@misosi.ru>

WORKDIR /work

RUN apk update && \
    apk add alpine-sdk git curl python python-dev py-pip libffi-dev libressl-dev memcached libmemcached-dev zlib-dev cyrus-sasl-dev mysql-client mysql-dev
RUN pip install simplejson pylibmc MySQL-python pycrypto

RUN git clone https://github.com/ahmedbodi/stratum-mining.git && \
    git clone https://github.com/ahmedbodi/stratum.git && \
    git clone https://github.com/bitzeny/zny_yescrypt_python.git

RUN cd stratum-mining && \
    git submodule init && \
    git submodule update

RUN cd stratum-mining && \
    curl https://gist.githubusercontent.com/bitzeny/9db1723161bc2650a1b1/raw/82197337372d4cd2079cd21c948bc6151fa1ca62/stratum.patch | \
         tail -n +4 | \
         sed -e "s/zny_yesscrypt/zny_yescrypt/" \
         > stratum.patch && \
    patch -p1 < stratum.patch

RUN cd stratum && \
    sed -i -e "s/use_setuptools()//" setup.py && \
    python setup.py install

RUN cd zny_yescrypt_python && python setup.py install

RUN cd stratum-mining && \
    sed -i -e 's/config = None/raise/' lib/settings.py && \
    sed -i -e "/^sys\.path =/s/.*/sys.path = [os.path.join(os.getcwd(), 'conf'),os.path.join(os.getcwd(), '.'),os.path.join(os.getcwd(), 'externals', 'stratum-mining-proxy'),] + sys.path/" launcher.tac

COPY entrypoint /entrypoint
RUN chmod +x /entrypoint

EXPOSE 19252
ENTRYPOINT ["/entrypoint"]
