FROM yanana/nginx-consul-template

ADD app.conf /etc/consul-templates/app.conf.ctmpl
