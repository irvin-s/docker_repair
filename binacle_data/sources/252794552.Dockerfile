FROM scratch  
MAINTAINER asko.soukka@iki.fi  
ENV USER="user" HOME="/home/user" \  
NIX_PATH="nixpkgs=/var/nixpkgs" \  
GIT_SSL_CAINFO="/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt" \  
SSL_CERT_FILE="/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt"  
# Bootstrap env using busybox  
ADD busybox /busybox  
RUN ["/busybox/busybox-86_64", "ln", "-s", "/busybox", "/bin"]  
RUN \  
# Download and unpack Nix  
version="1.10" && \  
basename="nix-$version-x86_64-linux" && \  
wget -O- http://nixos.org/releases/nix/nix-$version/$basename.tar.bz2 | \  
bzcat - | tar xf - && \  
mv nix-1.10-x86_64-linux /nix && \  
\  
# Download, unpack Nixpkgs  
wget -O- http://nixos.org/channels/nixpkgs-unstable/nixexprs.tar.xz | \  
xz -d - | tar xf - && \  
mkdir -p -m 0555 /var && mv nixpkgs* /var/nixpkgs && \  
\  
# Create a non-root Nix user  
mkdir -p -m 0755 /home && touch /etc/passwd && touch /etc/group && \  
adduser \--disabled-password --gecos '' user && \  
chown user:user -R /bin /busybox && chown user:user -R /nix && \  
su - user -c "mkdir -p /home/user/.nix-defexpr/channels" && \  
su - user -c "ln -s /var/nixpkgs /home/user/.nix-defexpr/channels" && \  
\  
# Init Nix and its default profile  
mkdir -p -m 0777 /tmp && \  
nix=`find /nix -type d -name "*-nix-*"` && \  
su - user -c "$nix/bin/nix-store --init" && \  
su - user -c "$nix/bin/nix-store --load-db < /nix/.reginfo" && \  
su - user -c "$nix/bin/nix-env -i $nix --option use-binary-caches false \  
`find /nix -type d -name '*-cacert-'*` \  
`find /nix -type d -name '*-bash-'*` \  
`find /nix -type d -name '*-bzip2-'*` \  
`find /nix -type d -name '*-coreutils-*'` \  
`find /nix -type d -name '*-curl-*'` \  
`find /nix -type d -name '*-gnutar-*'` \  
`find /nix -type d -name '*-gzip-*'` \  
`find /nix -type d -name '*-xz-*'`" && \  
su - user -c "$nix/bin/nix-collect-garbage -d" && \  
\  
# Fix permissions  
chmod a-ws -R /nix && chmod u+w -R /nix/var && chmod u+w /nix/store && \  
\  
# Cleanup  
rm -rf /nix/.reginfo /busybox /bin && \  
/nix/var/nix/profiles/default/bin/ln -s /nix/var/nix/profiles/default/bin /  
USER user  
WORKDIR /home/user  

