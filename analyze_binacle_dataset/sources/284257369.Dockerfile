FROM jupyter/scipy-notebook:abdb27a6dfbb

# Do the pip installs as the unprivileged notebook user
# USER jovyan

# Upgrade pip
RUN pip install --upgrade pip

# Install dashboard layout and preview within Jupyter Notebook
RUN pip install nb2kg && \
    jupyter serverextension enable --py nb2kg --sys-prefix

# Run with remote kernel managers
CMD ["jupyter", "notebook", \
     "--NotebookApp.ip=0.0.0.0", \
     "--NotebookApp.session_manager_class=nb2kg.managers.SessionManager", \
     "--NotebookApp.kernel_manager_class=nb2kg.managers.RemoteKernelManager", \
     "--NotebookApp.kernel_spec_manager_class=nb2kg.managers.RemoteKernelSpecManager"]
