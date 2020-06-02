FROM sath89/oracle-12c
RUN apt-get update && apt-get install -y software-properties-common openjdk-7-jre-headless \
    && ln -s /usr/share/java/bcprov.jar /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/ext/bcprov.jar \
    && awk -F . -v OFS=. 'BEGIN{n=2}/^security\.provider/ {split($3, posAndEquals, "=");$3=n++"="posAndEquals[2];print;next} 1' /etc/java-7-openjdk/security/java.security > /tmp/java.security \
    && echo "security.provider.1=org.bouncycastle.jce.provider.BouncyCastleProvider" >> /tmp/java.security \
    && mv /tmp/java.security /etc/java-7-openjdk/security/java.security \
    && apt-get remove -y openjdk-7-jre-headless \
    && apt-get update \
    && add-apt-repository -y ppa:kalon33/gamesgiroll \
    && add-apt-repository -y ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y openjdk-8-jre-headless libbcprov-java bats \
    && cp /u01/app/oracle-product/12.1.0/xe/jdk/lib/tools.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/

