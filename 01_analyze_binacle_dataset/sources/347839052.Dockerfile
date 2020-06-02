FROM local/controller:v1

MAINTAINER YanMing, yanming02@baidu.com

RUN cd /go/src/github.com/ksarch-saas/cc/cli && ../godep go install
COPY .cc_cli_config /root
COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
