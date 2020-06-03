FROM fedora:latest

MAINTAINER yesterday679 <yesterday679@gmail.com>

RUN dnf install dnf-plugins-core -y \
    && dnf config-manager --add-repo https://openresty.org/package/fedora/openresty.repo \
    && dnf install openresty -y \
    && dnf install openresty-resty -y \
    && dnf install openresty-opm -y \
    && dnf install lua -y \
    && echo -e "if [ -d \"\$HOME/bin\" ] ; then \n\tPATH=\"\$HOME/bin:\$PATH\"\nfi\nPATH=\"\$PATH:/usr/local/openresty/bin:/usr/local/openresty/luajit/bin:/usr/local/bin\"" >> ~/.profile \
    && rm -rf /usr/local/openresty/nginx/conf/nginx.conf

COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

RUN rm -rf /var/cache/dnf/*

EXPOSE 8888

CMD ["openresty", "-g", "daemon off;"]