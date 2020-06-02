FROM kcmerrill/base

RUN ln -s /yoda/yoda /usr/sbin/yoda

COPY . /yoda

ENTRYPOINT ["yoda"]
CMD ["version"]
