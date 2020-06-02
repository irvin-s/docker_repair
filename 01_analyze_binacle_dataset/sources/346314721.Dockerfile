FROM bitnami/apache:2.4.17-1-r02
ENV WORDPRESS_VERSION=4.3.2 \
    WORDPRESS_INSTALL_DIR=/app

RUN curl -sSL https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz -o /tmp/wordpress-${WORDPRESS_VERSION}.tar.gz \
 && mkdir -p $WORDPRESS_INSTALL_DIR \
 && tar -xf /tmp/wordpress-${WORDPRESS_VERSION}.tar.gz --strip=1 -C $WORDPRESS_INSTALL_DIR \
 && curl -sSL https://github.com/timwhite/wp-amazon-web-services/archive/master.tar.gz -o /tmp/wp2cloud-amazon-web-services.tar.gz \
 && mkdir -p $WORDPRESS_INSTALL_DIR/wp-content/plugins/amazon-web-services \
 && tar -xf /tmp/wp2cloud-amazon-web-services.tar.gz --strip=1 -C $WORDPRESS_INSTALL_DIR/wp-content/plugins/amazon-web-services \
 && curl -sSL https://github.com/timwhite/wp-amazon-s3-and-cloudfront/archive/master.tar.gz -o /tmp/amazon-s3-and-cloudfront.tar.gz \
 && mkdir -p $WORDPRESS_INSTALL_DIR/wp-content/plugins/amazon-s3-and-cloudfront \
 && tar -xf /tmp/amazon-s3-and-cloudfront.tar.gz --strip=1 -C $WORDPRESS_INSTALL_DIR/wp-content/plugins/amazon-s3-and-cloudfront \
 && chown -R $BITNAMI_APP_USER:$BITNAMI_APP_USER $WORDPRESS_INSTALL_DIR \
 && rm -rf /var/lib/apt /var/cache/apt/archives/* /tmp/*

COPY rootfs/ /

WORKDIR $WORDPRESS_INSTALL_DIR
