FROM nginx:latest
COPY ./wait-for-it.sh /
RUN chmod +x /wait-for-it.sh
RUN apt-get update && apt-get install -y ca-certificates && apt-get clean all
COPY INFN-CA-2015.pem /usr/local/share/ca-certificates/INFN-CA-2015.crt
COPY igi-test-ca.pem /usr/local/share/ca-certificates/igi-test-ca.crt
COPY nginx.conf /etc/nginx/
COPY iam.conf /etc/nginx/conf.d/default.conf
COPY iam.key.pem /etc/ssl/private/
COPY iam.cert.pem /etc/ssl/certs/
RUN update-ca-certificates
