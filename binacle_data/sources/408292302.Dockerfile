FROM registry.theopencloset.net/opencloset/perl:latest

RUN groupadd opencloset && useradd -g opencloset opencloset

WORKDIR /tmp
COPY cpanfile.sms-notifier cpanfile
RUN cpanm --notest \
    --mirror http://www.cpan.org \
    --mirror http://cpan.theopencloset.net \
    --installdeps .

# Everything up to cached.
WORKDIR /home/opencloset/service/staff.theopencloset.net
COPY ./bin/opencloset-sms-notifier.pl ./bin/opencloset-sms-notifier.pl
COPY ./app.conf.sample ./app.conf
RUN chown -R opencloset:opencloset .

USER opencloset
# ENV OPENCLOSET_COOLSMS_API_KEY='REQUIRED'
# ENV OPENCLOSET_COOLSMS_API_SECRET='REQUIRED'
# ENV OPENCLOSET_APISTORE_ID='REQUIRED'
# ENV OPENCLOSET_APISTORE_API_STORE_KEY='REQUIRED'
# ENV OPENCLOSET_SMS_NOTIFIER_EMAIL='REQUIRED'
# ENV OPENCLOSET_SMS_NOTIFIER_PASSWORD='REQUIRED'
ENV OPENCLOSET_SMS_NOTIFIER_FAKE_SMS=0
ENV OPENCLOSET_SMS_NOTIFIER_DELAY=10
ENV OPENCLOSET_SMS_NOTIFIER_SEND_DELAY=1
ENV OPENCLOSET_SMS_NOTIFIER_BASE_URL='https://staff.theopencloset.net/api'

CMD ["./bin/opencloset-sms-notifier.pl", "./app.conf"]
