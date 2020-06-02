FROM @FROM@

ONBUILD RUN rm /var/www/blog/public/admin/install.php || true

WORKDIR /etc/httpd
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
#CMD ["-D", "FOREGROUND"]
#ENTRYPOINT ["/usr/sbin/httpd"]
