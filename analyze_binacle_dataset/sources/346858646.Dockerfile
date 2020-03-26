FROM zuazo/chef-local:debian-7

COPY Berksfile /tmp/java/Berksfile
COPY attributes.json /tmp/attributes.json
RUN berks vendor -b /tmp/java/Berksfile $COOKBOOK_PATH
RUN chef-client -j /tmp/attributes.json -r "recipe[java]"

ENTRYPOINT ["java"]
CMD ["-version"]
