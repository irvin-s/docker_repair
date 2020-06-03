FROM ansibleplaybookbundle/apb-base:canary  
  
LABEL "com.redhat.apb.spec"=\  
"LS0tCnZlcnNpb246IDEuMApuYW1lOiBoZWxsby13b3JsZC1hcGIKZGVzY3JpcHRpb246IGRlcGxv\  
eXMgaGVsbG8td29ybGQgd2ViIGFwcGxpY2F0aW9uCmJpbmRhYmxlOiAiRmFsc2UiCmFzeW5jOiBv\  
cHRpb25hbAptZXRhZGF0YToKICBkaXNwbGF5TmFtZTogSGVsbG8gV29ybGQgKEFQQikKICBsb25n\  
RGVzY3JpcHRpb246CiAgICBBIHNhbXBsZSBBUEIgd2hpY2ggZGVwbG95cyBhIGNvbnRhaW5lcml6\  
ZWQgSGVsbG8gV29ybGQgd2ViIGFwcGxpY2F0aW9uCiAgZGVwZW5kZW5jaWVzOiBbJ2RvY2tlci5p\  
by9hbnNpYmxlcGxheWJvb2tidW5kbGUvaGVsbG8td29ybGQ6bGF0ZXN0J10KICBwcm92aWRlckRp\  
c3BsYXlOYW1lOiAiUmVkIEhhdCwgSW5jLiIKcGxhbnM6CiAgLSBuYW1lOiBkZWZhdWx0CiAgICBk\  
ZXNjcmlwdGlvbjogQSBzYW1wbGUgQVBCIHdoaWNoIGRlcGxveXMgSGVsbG8gV29ybGQKICAgIGZy\  
ZWU6ICJUcnVlIgogICAgbWV0YWRhdGE6CiAgICAgIGRpc3BsYXlOYW1lOiBEZWZhdWx0CiAgICAg\  
IGxvbmdEZXNjcmlwdGlvbjoKICAgICAgICBUaGlzIHBsYW4gZGVwbG95cyBhIFB5dGhvbiB3ZWIg\  
YXBwbGljYXRpb24gZGlzcGxheWluZyBIZWxsbyBXb3JsZAogICAgICBjb3N0OiAkMC4wMAogICAg\  
cGFyYW1ldGVyczogW10K"  
ADD playbooks /opt/apb/actions  
  
# Add our role into the ansible roles dir  
ADD . /opt/ansible/roles/hello-world-apb  
  
RUN chmod -R g=u /opt/{ansible,apb}  
  
USER apb  

