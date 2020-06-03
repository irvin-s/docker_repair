FROM pypy:2

# Install the necessary packages:
RUN pip install pytz psycopg2cffi
RUN apt-get update && apt-get install -y \
    python-psycopg2 \
    python-tz \
    postgresql-client \
 && apt-get clean && rm -rf /var/lib/apt/lists/*
 
# Copy the files we need:
COPY cmbarter /usr/local/share/cmbarter/cmbarter/
COPY execute_turn.py \
     generate_regkeys.py \
     process_emails.py \
     schedule_turns.py \
     show_emails.py \
     show_whitelist.py \
     set_language.py \
     docker/repeat_tasks.sh \
     /usr/local/bin/

CMD ["repeat_tasks.sh"]

ENV PYTHONPATH /usr/local/share/cmbarter
ENV PGHOST db
ENV PGDATABASE cmbarter
ENV PGUSER postgres

################################################################################

# The minimum cycle value (MCV) is the monetary value below which a
# trading cycle is considered not worthy of being executed. Bigger
# MCVs may speed up the execution of trading turns, but too big MCVs
# may miss worthy deals. "MINOR_DIGITS" controls how big the minimum
# cycle value should be:
#  0  =>  MCV=0.01
#  1  =>  MCV=0.1
#  2  =>  MCV=1
#  3  =>  MCV=10
#  4  =>  MCV=100
# and so forth...
ENV MINOR_DIGITS 0

# Set this to the name and the port of the outgoing mail server.
ENV SMTP_HOST mail:25

# Set this to the username for the SMTP authentication, or leave it
# empty if authentication is not required by the mail server.
ENV SMTP_USERNAME=

# Set this to the password for the SMTP authentication, or leave it
# empty if authentication is not required by the mail server.
ENV SMTP_PASSWORD=

# Set this to "none", "SSL", or "STARTTLS".
ENV SMTP_ENCRYPTION none

# Set this to your site domain name.
ENV CMBARTER_HOST localhost

# Set this to the PostgreSQL database connection string.
ENV CMBARTER_DSN host=db dbname=cmbarter user=postgres password=mysecretpassword
