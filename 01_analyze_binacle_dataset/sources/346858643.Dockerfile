FROM zuazo/chef-local:debian-7

COPY . /tmp/apache2
RUN berks vendor -b /tmp/apache2/Berksfile $COOKBOOK_PATH
RUN chef-client -r "recipe[apache2]"

CMD ["apache2", "-D", "FOREGROUND"]
