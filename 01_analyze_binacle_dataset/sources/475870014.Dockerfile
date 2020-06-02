FROM telephoneorg/debian:jessie

MAINTAINER Joe Black <me@joeblack.nyc>

ARG     ERLANG_VERSION
ARG     FREESWITCH_VERSION
ARG     KAZOO_CONFIGS_BRANCH

        # if choosing a module for mod a codec, use FREESWITCH_INSTALL_CODECS instead
        # options: abstraction,amqp,amr,amrwb,av,avmd,b64,basic,bert,blacklist,bv,callcenter,cdr-csv,cdr-mongodb,cdr-sqlite,cidlookup,cluechoo,codec2,commands,conference,console,curl,cv,dahdi-codec,db,dialplan-asterisk,dialplan-directory,dialplan-xml,dingaling,directory,distributor,dptools,easyroute,enum,erlang-event,esf,esl,event-multicast,event-socket,expr,fifo,flite,format-cdr,fsk,fsv,g723-1,g729,graylog2,h26x,hash,hiredis,httapi,http-cache,ilbc,imagick,isac,java,json-cdr,kazoo,lcr,ldap,local-stream,logfile,loopback,lua,managed,memcache,mod-say,mongo,mp4,mp4v,native-file,nibblebill,odbc-cdr,opus,oreka,perl,png,pocketsphinx,portaudio,portaudio-stream,posix-timer,prefix,python,rayo,redis,rss,rtc,rtmp,sangoma-codec,say-de,say-en,say-es,say-es-ar,say-fa,say-fr,say-he,say-hr,say-hu,say-it,say-ja,say-nl,say-pl,say-pt,say-ru,say-sv,say-th,say-zh,shell-stream,shout,silk,siren,skinny,skypopen,sms,snapshot,sndfile,snmp,snom,sofia,sonar,soundtouch,spandsp,spy,ssml,stress,syslog,theora,timerfd,tone-stream,translate,tts-commandline,unimrcp,v8,valet-parking,verto,vlc,vmd,voicemail,voicemail-ivr,vpx,xml-cdr,xml-curl,xml-ldap,xml-rpc,xml-scgi,yaml
ARG     FREESWITCH_INSTALL_MODS
ARG     FREESWITCH_INSTALL_CODECS

        # options: de,en,es,fr,he,lang,pt,ru,sv
ARG     FREESWITCH_INSTALL_LANGS

        # options: all,bare,codecs,conf,default,lang,mod-say,sorbet,vanilla
ARG     FREESWITCH_INSTALL_META
ARG     FREESWITCH_INSTALL_DEBUG
ARG     FREESWITCH_LOAD_MODS

ENV     ERLANG_VERSION ${ERLANG_VERSION:-19.2}
ENV     FREESWITCH_VERSION ${FREESWITCH_VERSION:-1.6}
ENV     KAZOO_CONFIGS_BRANCH ${KAZOO_CONFIGS_BRANCH:-4.1}
ENV     FREESWITCH_INSTALL_MODS ${FREESWITCH_INSTALL_MODS:-commands,conference,console,dptools,dialplan-xml,enum,event-socket,flite,http-cache,local-stream,loopback,say-en,sndfile,sofia,tone-stream}
ENV     FREESWITCH_INSTALL_CODECS ${FREESWITCH_INSTALL_CODECS:-amr,amrwb,g723-1,g729,h26x,opus,shout,silk,spandsp}
ENV     FREESWITCH_INSTALL_LANGS ${FREESWITCH_INSTALL_LANGS:-en,es,ru}
ENV     FREESWITCH_INSTALL_META ${FREESWITCH_INSTALL_META:-}
ENV     FREESWITCH_INSTALL_DEBUG ${FREESWITCH_INSTALL_DEBUG:-false}
ENV     FREESWITCH_LOAD_MODS ${FREESWITCH_LOAD_MODULES:-g729,silk}

LABEL   lang.erlang.version=$ERLANG_VERSION
LABEL   app.freeswitch.version=$FREESWITCH_VERSION

ENV     APP freeswitch
ENV     USER $APP
ENV     HOME /opt/$APP

COPY    build.sh /tmp/
RUN     /tmp/build.sh

COPY    build/freeswitch.limits.conf /etc/security/limits.d/
COPY    entrypoint /

ENV     FREESWITCH_LOG_LEVEL info
ENV     FREESWITCH_RTP_PORT_RANGE 16384-32768
ENV     FREESWITCH_DISABLE_NAT_DETECTION true
ENV     FREESWITCH_ENABLE_TLS false
ENV     FREESWITCH_CAPTURE_SERVER false
ENV     FREESWITCH_CAPTURE_IP 127.0.0.1

EXPOSE  8021 8031 11000
# 16384-24576/udp

VOLUME  ["/volumes/ram/", \
         "/volumes/freeswitch/storage", \
         "/volumes/freeswitch/recordings"]

WORKDIR $HOME

SHELL       ["/bin/bash", "-lc"]
HEALTHCHECK --interval=15s --timeout=5s \
    CMD fs_cli -x status | grep -q ^UP || exit 1

ENTRYPOINT  ["/dumb-init", "--"]
CMD         ["/entrypoint"]
