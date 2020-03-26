FROM fpco/stack-build:lts-7.15  
COPY ./stack.yaml /cafe-duty/stack.yaml  
COPY ./cafe-duty.cabal /cafe-duty/cafe-duty.cabal  
  
WORKDIR /cafe-duty  
  
RUN stack --system-ghc build --dependencies-only  
  
COPY . /cafe-duty  
  
RUN stack --system-ghc build  
  
CMD ["stack","--system-ghc","exec","cafe-duty"]

