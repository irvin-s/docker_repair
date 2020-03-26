FROM jupyter/scipy-notebook:abdb27a6dfbb

# install the kernel gateway
RUN pip install 'jupyter_kernel_gateway==1.1.2'

# run kernel gateway on container start, not notebook server
EXPOSE 8888
CMD ["jupyter", "kernelgateway", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=8888"]
