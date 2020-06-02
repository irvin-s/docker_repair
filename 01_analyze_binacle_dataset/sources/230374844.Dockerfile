FROM auth_proxy_build_base

COPY ./ /go/src/github.com/contiv/auth_proxy

ENTRYPOINT ["/bin/bash", "./scripts/unittests_in_container.sh"]
