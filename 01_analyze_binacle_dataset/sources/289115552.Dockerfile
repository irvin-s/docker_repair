FROM perl:5.28.0-slim AS builder

ENV LOG4PERL_CONFIG_FILE=log4perl-json.conf

ENV PORT=8000

# we run a loopback logging server on this TCP port.
ENV LOGGING_PORT=5880

RUN apt-get update
RUN apt-get install -y \
    build-essential curl libssl-dev zlib1g-dev openssl \
    libexpat-dev cmake git libcairo-dev libgd-dev \
    default-libmysqlclient-dev
RUN cpanm --notest Module::CPANfile App::cpm

WORKDIR /app
COPY Makefile.PL Bugzilla.pm gen-cpanfile.pl /app/
COPY extensions/ /app/extensions/

RUN perl Makefile.PL
RUN make cpanfile
RUN grep -r Tie::IxHash cpanfile
RUN cpm install

RUN apt-get install -y apt-file
RUN apt-file update
RUN find local -name '*.so' -exec ldd {} \; \
    | egrep -v 'not.found|not.a.dynamic.executable' \
    | awk '$3 {print $3}' \
    | sort -u \
    | xargs -IFILE apt-file search -l FILE \
    | sort -u > PACKAGES

FROM perl:5.28.0-slim

WORKDIR /app

COPY --from=builder /app/local /app/local
COPY --from=builder /app/PACKAGES /app/PACKAGES

RUN apt-get update && apt-get upgrade -y && apt-get install -y $(cat PACKAGES)

COPY . /app

ENV LOCALCONFIG_ENV=1
RUN perl checksetup.pl --no-database --default-localconfig && \
    rm -rf /app/data /app/localconfig && \
    mkdir /app/data

EXPOSE $PORT

ENTRYPOINT ["/app/bugzilla.pl"]
CMD ["daemon"]

