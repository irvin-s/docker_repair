FROM pypy:2

# Install the necessary packages:
RUN pip install Django~=1.11 psycopg2cffi Pillow pytz gevent gunicorn

# Install pgbouncer:
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y --no-install-recommends install \
    postgresql-common \
 && apt-get clean && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /opt \
 && cd /opt \
 && git clone https://github.com/pgbouncer/pgbouncer.git \
 && cd /opt/pgbouncer \
 && git checkout pgbouncer_1_7_2 \
 && git submodule init \
 && git submodule update \
 && ./autogen.sh \
 && ./configure --enable-evdns=no \
 && make \
 && make install \
 && rm -rf /opt/pgbouncer
 
# Copy the files we need:
COPY cmbarter /usr/local/share/cmbarter/cmbarter/
COPY doc /usr/local/share/cmbarter/doc/
COPY static /usr/local/share/cmbarter/static/
COPY generate_regkeys.py /usr/local/bin/
COPY docker/read_secrets.sh /usr/local/bin/

# "read_secrets.sh" verifies if CMBARTER_REGISTRATION_SECRET and
#  CMBARTER_SECRET_KEY environment variables are set. If one is not
#  set, it tries to set it to the contents of the file with the same
#  name (the name of the variable) in the /run/secrets/ directory.
ENTRYPOINT ["read_secrets.sh"]

CMD ["gunicorn", "cmbarter.wsgi"]

EXPOSE 8000

ENV PYTHONPATH /usr/local/share/cmbarter
ENV GUNICORN_CMD_ARGS -b :8000 -k gevent --log-level=warning --access-logfile=- --error-logfile=-

################################################################################

# Set this to the number of worker processes for handling requests --
# a positive integer generally in the 2-4 * $NUM_CORES range. You may
# want to vary this a bit to find the best for your particular
# workload.
ENV WEB_CONCURRENCY 1

# Set this to your site domain name.
ENV CMBARTER_HOST localhost

# Set this to the PostgreSQL database connection string.
ENV CMBARTER_DSN host=db dbname=cmbarter user=postgres password=mysecretpassword

# Leave this variable empty or set it to a random, long, secret string.
ENV CMBARTER_SECRET_KEY=

# This should point to a page telling more about the site.
ENV CMBARTER_ABOUT_US_URL https://sourceforge.net/projects/cmb/

# This should be "False" in production.
ENV CMBARTER_DEBUG_MODE False

# Sign-up and log-in settings:
ENV CMBARTER_MIN_PASSWORD_LENGTH 10
ENV CMBARTER_SHOW_CAPTCHA_ON_SIGNUP True
ENV CMBARTER_SHOW_CAPTCHA_ON_REPETITIVE_LOGIN_FAILURE True

# By default, CMB is configured to show CAPTHCA on sign-up, and after
# five unsuccessful attempts to log-in. If you have not altered the
# default behavior, you should obtain your own public/private key pair
# from www.google.com/recaptcha, and put it here:
ENV CMBARTER_RECAPTCHA_PUBLIC_KEY 6Ledx7wSAAAAAICFw8vB-2ghpDjzGogPRi6-3FCr
ENV CMBARTER_RECAPTCHA_PIVATE_KEY 6Ledx7wSAAAAAEskQ7Mbi-oqneHDSFVUkxGitn_y

# If a non-empty string is set as registration secret, CMB will
# require a registration key for users to sign up. In this case
# "generate_regkeys.py" can be used to generate user registration
# keys. Also, an URL can be specified that redirects to a web page
# where users are told how to obtain a registration key.
ENV CMBARTER_REGISTRATION_SECRET=
ENV CMBARTER_REGISTRATION_KEY_HELP_URL=

# The time zone of your users. For example: Europe/Rome
ENV CMBARTER_DEFAULT_USERS_TIME_ZONE=

# Set this to a page where users can search for trusted partners.
ENV CMBARTER_SEARCH_PARTNERS_URL=

# This is the maximum size in bytes for users' uploaded photographs.
ENV CMBARTER_MAX_IMAGE_SIZE 716800

# This is the maximum amount of pixels (width * height) in users'
# uploaded photographs.
ENV CMBARTER_MAX_IMAGE_PIXELS 30000000

# By default, CMB is configured to maintain a whitelist of "good" IP
# addresses. This auto-generated whitelist can be used to configure
# your firewall to protect your web-servers from DoS attacks. To be
# able to reliably determine the IP addresses of your clients, CMB
# should know the IP address(es) of all reverse proxy servers in your
# network. Normally, here you should substitute 'proxy' with the name
# or the IP of your reverse-proxy server. If you have more than one
# reverse-proxy in your network, you should pass them all like this:
# hosts(\'proxy1\', \'proxy2\', \'proxy3\')
#
# NOTE: The backslashes are needed to escape the quotes.
ENV CMBARTER_REVERSE_PROXIES hosts(\'proxy\')
