FROM ruby:2.2.2

RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ADD reschedule.gemspec $APP_HOME/
ADD lib/reschedule/version.rb $APP_HOME/lib/reschedule/version.rb
RUN bundle install

ADD . $APP_HOME

ENV KUBERNETES_API_URL https://kubernetes.mycompany.com/api/

# Authentication option 1: HTTP basic auth
ENV KUBERNETES_API_USERNAME myusername
ENV KUBERNETES_API_PASSWORD mypassword

# Authentication option 2: client certificate
ENV KUBERNETES_API_CLIENT_KEY myclientkey
ENV KUBERNETES_API_CLIENT_CERT myclientcert
ENV KUBERNETES_API_CA_FILE path/to/my/ca/file

ENTRYPOINT ["bundle", "exec"]
CMD ["./bin/reschedule"]
