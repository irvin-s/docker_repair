FROM @FROM@

ONBUILD RUN rm /var/www/blog/public/admin/install.php || true

WORKDIR /etc/apache2
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "DEFAULT_VHOST", "-D", "PHP5", "-D", "LANGUAGE", "-D", "FOREGROUND"]
#CMD ["-D", "DEFAULT_VHOST", "-D", "PHP5", "-D", "LANGUAGE", "-D", "FOREGROUND"]
#ENTRYPOINT ["/usr/sbin/apache2"]
