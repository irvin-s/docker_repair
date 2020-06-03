FROM @FROM@

ONBUILD RUN rm /var/www/blog/public/admin/install.php || true

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

WORKDIR /etc/apache2
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
#CMD ["-D", "FOREGROUND"]
#ENTRYPOINT ["/usr/sbin/apache2"]
