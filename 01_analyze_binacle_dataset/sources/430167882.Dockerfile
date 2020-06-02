FROM ubuntu
MAINTAINER joridos <jonatam.ribeiro@hotmail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  apache2

# use Apache2hHostCreate.sh
ADD Apache2hHostCreate.sh Apache2hHostCreate.sh
ENTRYPOINT ["./Apache2hHostCreate.sh"]

