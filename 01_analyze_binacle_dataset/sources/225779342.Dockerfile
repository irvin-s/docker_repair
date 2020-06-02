FROM ruby:2.2

# Install mailcatcher Server
RUN apt-get update && apt-get install -y build-essential sqlite3 libsqlite3-dev
RUN gem install mailcatcher -v 0.6.4 --no-ri --no-rdoc
RUN apt-get remove -y --purge build-essential libsqlite3-dev
RUN apt-get autoremove -y && apt-get clean

# SMTP Server
EXPOSE 1025
# HTTP Server
EXPOSE 1080

# Run mailcatcher
#CMD ["mailcatcher", "-f", "--ip=0.0.0.0"]
