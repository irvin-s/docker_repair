FROM ansibleplaybookbundle/apb-base  
  
LABEL "com.redhat.apb.version"="0.1.0"  
LABEL "com.redhat.apb.spec"=\  
"dmVyc2lvbjogMS4wCm5hbWU6IGNvcmRvdmEtYXBwLWFwYgpkZXNjcmlwdGlvbjogU2V0cyB1cCBh\  
IENvcmRvdmEgQXBwIHJlcHJlc2VudGF0aW9uLgpiaW5kYWJsZTogRmFsc2UKYXN5bmM6IG9wdGlv\  
bmFsCnRhZ3M6IAogIC0gbW9iaWxlCm1ldGFkYXRhOgogIGRpc3BsYXlOYW1lOiBDb3Jkb3ZhIEFw\  
cAogIGNvbnNvbGUub3BlbnNoaWZ0LmlvL2ljb25DbGFzczogZm9udC1pY29uIGljb24tY29yZG92\  
YQogIGltYWdlVXJsOiAiaW1hZ2VzL2xvZ29zL2NvcmRvdmEucG5nIgogIGRvY3VtZW50YXRpb25V\  
cmw6ICJodHRwOi8vZG9jcy5hZXJvZ2Vhci5vcmciCnBsYW5zOgogIC0gbmFtZTogZGVmYXVsdAog\  
ICAgZGVzY3JpcHRpb246IFNldHMgdXAgYSBDb3Jkb3ZhIEFwcCByZXByZXNlbnRhdGlvbi4KICAg\  
IGZyZWU6IFRydWUKICAgIG1ldGFkYXRhOiB7fQogICAgcGFyYW1ldGVyczoKICAgIC0gbmFtZTog\  
YXBwTmFtZQogICAgICByZXF1aXJlZDogVHJ1ZQogICAgICBkZWZhdWx0OiBteWFwcAogICAgICB0\  
eXBlOiBzdHJpbmcKICAgICAgdGl0bGU6IEFwcGxpY2F0aW9uIE5hbWUKICAgIC0gbmFtZTogYXBw\  
SWRlbnRpZmllcgogICAgICByZXF1aXJlZDogVHJ1ZQogICAgICB0eXBlOiBzdHJpbmcKICAgICAg\  
dGl0bGU6IFBhY2thZ2UgTmFtZQ=="  
  
COPY playbooks /opt/apb/actions  
COPY roles /opt/ansible/roles  
COPY mobile /usr/bin  
RUN chmod -R g=u /opt/{ansible,apb}  
USER apb  

