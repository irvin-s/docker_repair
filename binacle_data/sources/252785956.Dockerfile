FROM bitnami/minideb:stretch as builder  
  
# Set environment for building binary  
ENV HOME=/opt/shellcheck  
  
# Install GHC and cabal  
RUN install_packages \  
cabal-install \  
ghc  
  
WORKDIR /opt/shellcheck  
  
# Copy the shell check code to be built https://github.com/koalaman/shellcheck  
ADD source/ ./  
  
RUN cabal update && \  
cabal install --dependencies-only && \  
cabal build Paths_ShellCheck && \  
ghc -optl-static -optl-pthread -idist/build/autogen --make shellcheck && \  
mv shellcheck /bin && \  
rm -rf /opt/shellcheck  
  
FROM alpine:3.7  
COPY \--from=builder /bin/shellcheck /bin/  
  
CMD ["/bin/shellcheck"]  

