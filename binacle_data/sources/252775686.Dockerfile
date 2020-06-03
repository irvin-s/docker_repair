FROM ruby:2.1-onbuild  
CMD ["bundle", "exec", "ruby", "bin/blinkbox-onix2_processor"]

