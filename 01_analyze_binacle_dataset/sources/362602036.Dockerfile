FROM kstaken/apache2
LABEL name "lexicon-loop"
COPY index.html /var/www
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
