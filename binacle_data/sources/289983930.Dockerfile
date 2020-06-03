FROM ruby:2.4.0-onbuild

MAINTAINER Robert C. Broeckelmann Jr. <robert.broeckelmann@levvel.io>

EXPOSE 3000
CMD ["bundle", "exec", "rackup", "--port", "3000", "--host", "0.0.0.0"]
