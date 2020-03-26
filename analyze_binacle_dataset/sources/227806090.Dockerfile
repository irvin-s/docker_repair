FROM perl:5.28

# secure by default ♥ (thanks to sri!)
ENV PERL_CPANM_OPT --verbose --mirror https://cpan.metacpan.org
# TODO find a way to make --mirror-only / SSL work with backpan too :(
RUN cpanm Digest::SHA Module::Signature
# TODO find a way to make --verify work with backpan as well :'(
#ENV PERL_CPANM_OPT $PERL_CPANM_OPT --verify

# reinstall cpanm itself, for good measure
RUN cpanm App::cpanminus

RUN cpanm EV
RUN cpanm IO::Socket::IP
RUN cpanm IO::Socket::Socks
RUN cpanm Net::DNS::Native

# the tests for IO::Socket::SSL like to hang... :(
RUN cpanm --notest IO::Socket::SSL

# https://metacpan.org/pod/release/SRI/Mojolicious-7.94/lib/Mojo/IOLoop.pm#DESCRIPTION
ENV LIBEV_FLAGS 4
# epoll (Linux)

RUN cpanm Mojolicious@8.13

# http://mojolicious.org/perldoc/Mojolicious/Guides/FAQ#What-does-Inactivity-timeout-mean
ENV MOJO_INACTIVITY_TIMEOUT 120
# The Hub takes a while to respond, and the time it takes to respond increases as we stack up more pending requests. :)

COPY .remote.pl /usr/local/bin/remote.pl
ENTRYPOINT ["remote.pl"]
