FROM ruby:2.1-onbuild

COPY classifier.rb /usr/src/app/
COPY training /usr/src/app/.

