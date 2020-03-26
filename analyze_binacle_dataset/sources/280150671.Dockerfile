FROM kong:0.11

MAINTAINER Henrique Canto Duarte hcanto@cpqd.com.br

RUN yum -y update && yum -y install unzip openssl-devel

ADD load_kong_conf.sh /etc/kong

CMD /etc/kong/load_kong_conf.sh > /etc/kong/kong.conf ; \
    cd /plugins && \
    for d in $(find . -name *.rockspec -printf "%h\n") ; do (cd "$d" && luarocks make && cd -); done ; \
    kong start

ADD patches/openresty/lua-resty-string/aes.lua /usr/local/openresty/lualib/resty/aes.lua  
