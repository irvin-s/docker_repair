FROM ruby:2.1-onbuild
CMD /bin/bash -c "bundle exec rspec"
