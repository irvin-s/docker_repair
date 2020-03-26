FROM cassandra:3.11

COPY config/etc/cassandra/conf /etc/cassandra/conf
COPY config/.cassandra /root/.cassandra

RUN echo "authenticator: PasswordAuthenticator" | tee -a /etc/cassandra/cassandra.yaml && \
    sed -i \
        -e '/client_encryption_options:/,/cipher_suites:/ s/enabled: .*/enabled: true/' \
        -e '/client_encryption_options:/,/cipher_suites:/ s/keystore: .*/keystore: \/etc\/cassandra\/conf\/certs\/cassandra.keystore/' \
        -e '/client_encryption_options:/,/cipher_suites:/ s/# \(require_client_auth\): .*/\1: false/' \
        /etc/cassandra/cassandra.yaml
