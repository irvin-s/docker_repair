FROM jwilder/nginx-proxy:latest

RUN { \
      echo 'fastcgi_buffers 4 256k;'; \
      echo 'fastcgi_buffer_size 128k;'; \
      echo 'fastcgi_busy_buffers_size 256k;'; \
    } > /etc/nginx/conf.d/my_proxy.conf

RUN sed -i 's/^http {/&\n    proxy_busy_buffers_size   256k;/g' /etc/nginx/nginx.conf && \
    sed -i 's/^http {/&\n    proxy_buffers   4 256k;/g' /etc/nginx/nginx.conf && \
    sed -i 's/^http {/&\n    proxy_buffer_size   128k;/g' /etc/nginx/nginx.conf && \
    sed -i 's/^http {/&\n    client_max_body_size   108M;/g' /etc/nginx/nginx.conf