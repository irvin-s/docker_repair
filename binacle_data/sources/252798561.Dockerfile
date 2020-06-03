FROM alpine:3.5  
  
RUN apk --no-cache add \  
openssl \  
libssl1.0 \  
erlang \  
erlang-ssl \  
erlang-crypto \  
erlang-public-key \  
erlang-eunit \  
erlang-syntax-tools \  
erlang-parsetools \  
erlang-asn1 \  
erlang-dev \  
erlang-inets  
  
CMD ["/bin/sh"]

