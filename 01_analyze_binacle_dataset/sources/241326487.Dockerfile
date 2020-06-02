# OpenSSL with AWS CLI
#
# docker run --rm supinf/openssl:1.0 genrsa 4096 -aes256 -out private.pem > ./private.pem
# docker run --rm -v $(pwd):/work supinf/openssl:1.0 rsa -in private.pem -pubout -out public.pem
# docker run --rm -v $(pwd):/work supinf/openssl:1.0 encrypt.sh

FROM supinf/awscli:1.16

ENV OPENSSL_VERSION=1.0.2o-r2
RUN apk --no-cache add "openssl==${OPENSSL_VERSION}"

WORKDIR /work

ENTRYPOINT ["openssl"]
CMD ["version"]
