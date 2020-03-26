FROM ansibleplaybookbundle/apb-base  
  
LABEL "com.redhat.apb.version"="0.1.0"  
LABEL "com.redhat.apb.spec"=\  
"dmVyc2lvbjogMS4wCm5hbWU6IGFuZHJvaWQtYXBwLWFwYgpkZXNjcmlwdGlvbjogU2V0cyB1cCBh\  
biBBbmRyb2lkIEFwcCByZXByZXNlbnRhdGlvbi4KYmluZGFibGU6IEZhbHNlCmFzeW5jOiBvcHRp\  
b25hbAp0YWdzOiAKICAtIG1vYmlsZQptZXRhZGF0YToKICBkaXNwbGF5TmFtZTogQW5kcm9pZCBB\  
cHAKICBjb25zb2xlLm9wZW5zaGlmdC5pby9pY29uQ2xhc3M6IGZhIGZhLWFuZHJvaWQKICBkb2N1\  
bWVudGF0aW9uVXJsOiAiaHR0cDovL2RvY3MuYWVyb2dlYXIub3JnIgpwbGFuczoKICAtIG5hbWU6\  
IGRlZmF1bHQKICAgIGRlc2NyaXB0aW9uOiBTZXRzIHVwIGFuIEFuZHJvaWQgQXBwIHJlcHJlc2Vu\  
dGF0aW9uLgogICAgZnJlZTogVHJ1ZQogICAgbWV0YWRhdGE6IHt9CiAgICBwYXJhbWV0ZXJzOiAK\  
ICAgIC0gbmFtZTogYXBwTmFtZQogICAgICByZXF1aXJlZDogVHJ1ZQogICAgICBkZWZhdWx0OiBt\  
eWFwcAogICAgICB0eXBlOiBzdHJpbmcKICAgICAgdGl0bGU6IEFwcGxpY2F0aW9uIE5hbWUKICAg\  
IC0gbmFtZTogYXBwSWRlbnRpZmllcgogICAgICByZXF1aXJlZDogVHJ1ZQogICAgICB0eXBlOiBz\  
dHJpbmcKICAgICAgdGl0bGU6IFBhY2thZ2UgTmFtZQ=="  
  
COPY playbooks /opt/apb/actions  
COPY roles /opt/ansible/roles  
COPY mobile /usr/bin  
RUN chmod -R g=u /opt/{ansible,apb}  
USER apb  

