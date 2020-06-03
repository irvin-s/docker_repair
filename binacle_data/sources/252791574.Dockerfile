FROM haskell:8  
MAINTAINER Hong Minhee <hong.minhee@gmail.com>  
  
ENV LANG=en  
ENV GOOGLE_TRANSLATE_API_KEY=  
  
# Add just the .cabal file to capture dependencies  
COPY ./nicovideo-translator.cabal /app/nicovideo-translator.cabal  
  
WORKDIR /app  
  
# Docker will cache this command as a layer, freeing us up to  
# modify source code without re-installing dependencies  
# (unless the .cabal file changes!)  
RUN cabal update && cabal install --only-dependencies -j4  
  
COPY . /app  
RUN cabal install  
  
EXPOSE 8080  
CMD nicovideo-translator -p 8080 -l "$LANG" "$GOOGLE_TRANSLATE_API_KEY"  

