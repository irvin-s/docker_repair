FROM scratch

ADD target/x86_64-unknown-linux-musl/release/ganbare /ganbare/ganbare
ADD static /ganbare/static
ADD src /ganbare/src
ADD certs_temp /etc/ssl/certs
VOLUME /ganbare/audio /ganbare/images /ganbare/user_audio
ENV GANBARE_SERVER_BINDING=0.0.0.0:8080 \
	GANBARE_JQUERY=https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js \
	GANBARE_FONT_URL=https://fonts.googleapis.com/css?family=Source+Sans+Pro:300 \
	GANBARE_EMAIL_NAME=ganba.re応援団 \
    SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    SSL_CERT_DIR=/etc/ssl/certs
WORKDIR /ganbare
EXPOSE 8080
ENTRYPOINT ["/ganbare/ganbare"]
