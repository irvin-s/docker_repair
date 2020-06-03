FROM perl:5
RUN cpan App::cpanminus
RUN cpanm LWP::UserAgent MIME::Base64 JSON Config::Tiny Benchmark Scalar::Util LWP::Protocol::https
RUN apt-get update\
    && apt-get install -y cron\
    && rm -rf /var/lib/apt/lists/*
ADD graphite-collector /opt/netapp/E-Series-Graphite-Grafana/

RUN (crontab -l ; echo "* * * * * /usr/local/bin/perl /opt/netapp/E-Series-Graphite-Grafana/eseries-metrics-collector.pl -dc\
 /opt/netapp/E-Series-Graphite-Grafana/api-config.conf >> /var/log/metrics.log 2>&1") | crontab
RUN touch /var/log/metrics.log

CMD ["cron", "-f"]
