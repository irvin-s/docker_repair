FROM mono:4.2.1
RUN apt-get update
RUN apt-get install -y mono-devel nunit-console libtest-most-perl libipc-system-simple-perl xvfb git make libcurl4-gnutls-dev
RUN mozroots --import --ask-remove
RUN cpan App::FatPacker::Trace

ENV DISPLAY :99.0