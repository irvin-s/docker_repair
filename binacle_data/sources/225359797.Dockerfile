FROM kibana:4.5.4
MAINTAINER PubNative Team <team@pubnative.net>

RUN /opt/kibana/bin/kibana plugin --install kibana/timelion \
    && /opt/kibana/bin/kibana plugin --install elastic/sense \
    && /opt/kibana/bin/kibana plugin -i vectormap -u https://github.com/stormpython/vectormap/archive/master.zip \
    && /opt/kibana/bin/kibana plugin -i Kibana-extractor-plugin -u https://github.com/Napal-innovation/Kibana-extractor-plugin/archive/master.zip \
    && /opt/kibana/bin/kibana plugin -i prelert_swimlane_vis -u https://github.com/prelert/kibana-swimlane-vis/archive/v0.1.0.tar.gz \
    && /opt/kibana/bin/kibana plugin -i logtrail -u https://github.com/sivasamyk/logtrail/releases/download/0.1.4/logtrail-4.x-0.1.4.tar.gz \
    && chown -R kibana:kibana /opt/kibana
