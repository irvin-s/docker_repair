# Start from the jupyter image with R, Python, and Scala (Apache Toree) kernels pre-installed
FROM jupyter/all-spark-notebook:03b897d05f16

# Install the kernel gateway
RUN pip install jupyter_kernel_gateway

# Run kernel gateway on container start, not notebook server
EXPOSE 8889
CMD ["jupyter", "kernelgateway", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=8889"]
