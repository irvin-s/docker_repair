FROM ansibleplaybookbundle/apb-base  
  
LABEL "com.redhat.apb.version"="0.1.0"  
LABEL "com.redhat.apb.spec"=\  
"dmVyc2lvbjogMS4wCm5hbWU6IDNzY2FsZS1hcGIKZGVzY3JpcHRpb246ID4KICBVbmxvY2sgdGhl\  
IHBvd2VyIG9mIHlvdXIgQVBJcy4gVGhpcyB3aWxsIGRlcGxveSBBcGljYXN0IHRvIHlvdXIgT3Bl\  
bnNoaWZ0IGNsdXN0ZXIgYW5kIGNvbm5lY3QgCiAgaXQgdG8gYSBkZWRpY2F0ZWQgUmVkaXMuIEZv\  
ciB0aGlzIHRvIGZ1bmN0aW9uIGNvcnJlY3RseSBpdCBuZWVkcyB0byBiZSBjb25maWd1cmVkIHdp\  
dGggYSB0b2tlbgogIGFuZCBkb21haW4gZm9yIHRoZSBhY2NvdW50IGl0IHNob3VsZCBwdWxsIGl0\  
J3MgY29uZmlndXJhdGlvbiB2YWx1ZXMgZnJvbSAodXN1YWxseSBpbiAzc2NhbGUubmV0KS4KCiAg\  
WW91IGNhbiBjcmVhdGUgYW4gYWNjb3VudCB3aXRoIDNzY2FsZS5uZXQgaGVyZTogaHR0cHM6Ly93\  
d3cuM3NjYWxlLm5ldC9zaWdudXAvCmJpbmRhYmxlOiBUcnVlCmFzeW5jOiBvcHRpb25hbAp0YWdz\  
OgogIC0gbW9iaWxlLXNlcnZpY2UKbWV0YWRhdGE6CiAgZGlzcGxheU5hbWU6IDNTY2FsZQogIGlt\  
YWdlVXJsOiAiaHR0cHM6Ly9hdmF0YXJzMS5naXRodWJ1c2VyY29udGVudC5jb20vdS8yMTQxNT9z\  
PTIwMCZ2PTQiCiAgZG9jdW1lbnRhdGlvblVybDogImh0dHBzOi8vd3d3LjNzY2FsZS5uZXQvYXBp\  
LW1hbmFnZW1lbnQvaW50ZXJhY3RpdmUtYXBpLWRvY3VtZW50YXRpb24vIgogIHByb3ZpZGVyRGlz\  
cGxheU5hbWU6ICJSZWQgSGF0LCBJbmMuIgogIHNlcnZpY2VOYW1lOiAzc2NhbGUKcGxhbnM6CiAg\  
LSBuYW1lOiBkZWZhdWx0CiAgICBkZXNjcmlwdGlvbjogRGVwbG95IDNTY2FsZQogICAgZnJlZTog\  
VHJ1ZQogICAgbWV0YWRhdGE6IHt9CiAgICBwYXJhbWV0ZXJzOgogICAgLSBuYW1lOiBUSFJFRVND\  
QUxFX0RPTUFJTgogICAgICByZXF1aXJlZDogVHJ1ZQogICAgICBkZWZhdWx0OiAKICAgICAgdHlw\  
ZTogc3RyaW5nCiAgICAgIHRpdGxlOiAzU2NhbGUgZG9tYWluIG5hbWUsIGkuZS4gImV4YW1wbGUt\  
YWRtaW4uM3NjYWxlLm5ldCIKICAgIC0gbmFtZTogVEhSRUVTQ0FMRV9BQ0NFU1NfVE9LRU4KICAg\  
ICAgcmVxdWlyZWQ6IFRydWUKICAgICAgZGVmYXVsdDogCiAgICAgIHR5cGU6IHN0cmluZwogICAg\  
ICB0aXRsZTogM1NjYWxlIGFjY2VzcyB0b2tlbiAoaHR0cHM6Ly9zdXBwb3J0LjNzY2FsZS5uZXQv\  
ZG9jcy9hY2NvdW50cy90b2tlbnMjY3JlYXRpbmctYWNjZXNzLXRva2VucykKICAgIC0gbmFtZTog\  
VEhSRUVTQ0FMRV9TRVJWSUNFX0lECiAgICAgIHJlcXVpcmVkOiBUcnVlCiAgICAgIGRlZmF1bHQ6\  
IAogICAgICB0eXBlOiBzdHJpbmcKICAgICAgdGl0bGU6IDNTY2FsZSBzZXJ2aWNlIGlkCiAgICAt\  
IG5hbWU6IFRIUkVFU0NBTEVfRU5BQkxFX0NPUlMKICAgICAgcmVxdWlyZWQ6IFRydWUKICAgICAg\  
ZGVmYXVsdDogVHJ1ZQogICAgICB0eXBlOiBib29sCiAgICAgIHRpdGxlOiBFbmFibGUgQ09SUyAz\  
U2NhbGUgcGx1Z2luPwoK"  
  
RUN yum install -y jq  
  
COPY playbooks /opt/apb/actions  
COPY roles /opt/ansible/roles  
RUN chmod -R g=u /opt/{ansible,apb}  
USER apb  

