#ifndef DOCKERFILE_ENABLE_APT_CACHE
#define DOCKERFILE_ENABLE_APT_CACHE

#ifdef ENABLE_APT_CACHE

#// Make apt-get use a proxy to speed up Docker image rebuilds.
#//
#// To use this, you have to add the -DENABLE_APT_CACHE flag to 
#// the preprocessor command line.
#//
#// If you've installed squid-deb-proxy and squid-deb-proxy-client
#// on your Docker host, then the following line will automatically
#// point Docker container instances to the correct address:

RUN /sbin/ip route | awk '/default/ { print "Acquire::http::Proxy \"http://"$3":8000\";" }' > /etc/apt/apt.conf.d/30proxy

#// TODO: Possibly add `echo` of the above line to .bashrc

#endif // ENABLE_APT_CACHE

#endif // DOCKERFILE_ENABLE_APT_CACHE
