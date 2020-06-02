FROM openresty/openresty:1.13.6.2-2-xenial

# Install official copy to install dependencies
RUN opm install zmartzone/lua-resty-openidc=1.7.0

# Replace official with local copy
COPY lua-resty-openidc/lib/resty/ /usr/local/openresty/site/lualib/resty/

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

COPY lua/ /usr/local/openresty/nginx/lua/
COPY conf/ /usr/local/openresty/nginx/conf/

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
