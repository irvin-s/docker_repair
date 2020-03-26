FROM asaaki/base-dev:0.1.1  
MAINTAINER Christoph Grabo <asaaki@mannaz.cc>  
  
RUN apk --update add \  
'erlang<18.1' \  
'erlang-asn1<18.1' \  
'erlang-common-test<18.1' \  
'erlang-compiler<18.1' \  
'erlang-cosevent<18.1' \  
'erlang-coseventdomain<18.1' \  
'erlang-cosfiletransfer<18.1' \  
'erlang-cosnotification<18.1' \  
'erlang-cosproperty<18.1' \  
'erlang-costime<18.1' \  
'erlang-costransaction<18.1' \  
'erlang-crypto<18.1' \  
'erlang-debugger<18.1' \  
'erlang-dev<18.1' \  
'erlang-dialyzer<18.1' \  
'erlang-diameter<18.1' \  
'erlang-edoc<18.1' \  
'erlang-eldap<18.1' \  
'erlang-erl-docgen<18.1' \  
'erlang-erl-interface<18.1' \  
'erlang-erts<18.1' \  
'erlang-et<18.1' \  
'erlang-eunit<18.1' \  
'erlang-gs<18.1' \  
'erlang-hipe<18.1' \  
'erlang-ic<18.1' \  
'erlang-inets<18.1' \  
'erlang-jinterface<18.1' \  
'erlang-kernel<18.1' \  
'erlang-megaco<18.1' \  
'erlang-mnesia<18.1' \  
'erlang-observer<18.1' \  
'erlang-odbc<18.1' \  
'erlang-orber<18.1' \  
'erlang-os-mon<18.1' \  
'erlang-ose<18.1' \  
'erlang-otp-mibs<18.1' \  
'erlang-parsetools<18.1' \  
'erlang-percept<18.1' \  
'erlang-public-key<18.1' \  
'erlang-reltool<18.1' \  
'erlang-runtime-tools<18.1' \  
'erlang-sasl<18.1' \  
'erlang-snmp<18.1' \  
'erlang-ssh<18.1' \  
'erlang-ssl<18.1' \  
'erlang-stdlib<18.1' \  
'erlang-syntax-tools<18.1' \  
'erlang-test-server<18.1' \  
'erlang-tools<18.1' \  
'erlang-typer<18.1' \  
'erlang-webtool<18.1' \  
'erlang-xmerl<18.1' && \  
rm -rf /var/cache/apk/*  
  
RUN wget https://s3.amazonaws.com/rebar3/rebar3 -O /usr/local/bin/rebar3 && \  
chmod +x /usr/local/bin/rebar3 && \  
mkdir -p $HOME/.config/rebar3/ && \  
echo '{plugins, [rebar3_hex]}.' > $HOME/.config/rebar3/rebar.config && \  
rebar3 update && rebar3 plugins upgrade rebar3_hex  

