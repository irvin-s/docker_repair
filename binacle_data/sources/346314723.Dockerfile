FROM bitnami/php-fpm:5.5.30-2
ENV WORDPRESS_VERSION=4.3.2 \
    WORDPRESS_INSTALL_DIR=/app

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y unzip \
 && mkdir -p $WORDPRESS_INSTALL_DIR \
 && curl -sSL https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz -o /tmp/wordpress-${WORDPRESS_VERSION}.tar.gz \
 && tar -xf /tmp/wordpress-${WORDPRESS_VERSION}.tar.gz --strip=1 -C $WORDPRESS_INSTALL_DIR \
 && cp $WORDPRESS_INSTALL_DIR/wp-config-sample.php $WORDPRESS_INSTALL_DIR/wp-config.php \
 && mkdir -p $WORDPRESS_INSTALL_DIR/wp-content/plugins/amazon-web-services \
 && curl -sSL https://github.com/timwhite/wp-amazon-web-services/archive/master.tar.gz -o /tmp/wp2cloud-amazon-web-services.tar.gz \
 && tar -xf /tmp/wp2cloud-amazon-web-services.tar.gz --strip=1 -C $WORDPRESS_INSTALL_DIR/wp-content/plugins/amazon-web-services \
 && mkdir -p $WORDPRESS_INSTALL_DIR/wp-content/plugins/amazon-s3-and-cloudfront \
 && curl -sSL https://github.com/timwhite/wp-amazon-s3-and-cloudfront/archive/master.tar.gz -o /tmp/amazon-s3-and-cloudfront.tar.gz \
 && tar -xf /tmp/amazon-s3-and-cloudfront.tar.gz --strip=1 -C $WORDPRESS_INSTALL_DIR/wp-content/plugins/amazon-s3-and-cloudfront \
 && curl -sSL https://downloads.wordpress.org/plugin/hyperdb.1.1.zip -o /tmp/hyperdb.1.1.zip \
 && unzip /tmp/hyperdb.1.1.zip -d /tmp/ \
 && cp /tmp/hyperdb/db.php $WORDPRESS_INSTALL_DIR/wp-content/ \
 && chmod a-w $WORDPRESS_INSTALL_DIR/wp-content/db.php \
 && chown -R $BITNAMI_APP_USER:$BITNAMI_APP_USER $WORDPRESS_INSTALL_DIR \
 && rm -rf /var/lib/apt /var/cache/apt/archives/* /tmp/*

COPY rootfs/ /

WORKDIR $WORDPRESS_INSTALL_DIR
