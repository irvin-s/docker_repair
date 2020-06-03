# Build image upon Jekyll's official Docker image.  
# https://hub.docker.com/r/jekyll/jekyll/  
# https://github.com/jekyll/docker  
FROM jekyll/jekyll  
  
RUN \  
# Install tools required to build pygments.rb  
apk --update add build-base ruby-dev && \  
#  
# Install Python, which is required by pygments.rb  
apk --update add python && \  
# Install pygments.rb syntax highlighter  
# https://github.com/tmm1/pygments.rb  
# https://rubygems.org/gems/pygments.rb/versions/0.6.3  
gem install pygments.rb -v 0.6.3 && \  
# Install jekyll-asciidoc (also adds asciidoctor)  
# https://github.com/asciidoctor/jekyll-asciidoc  
# https://rubygems.org/gems/jekyll-asciidoc/versions/1.1.2  
gem install jekyll-asciidoc -v 1.1.2 && \  
#  
# Remove tools required to build pygments.rb  
apk del build-base ruby-dev  
  

