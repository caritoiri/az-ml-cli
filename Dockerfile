FROM continuumio/miniconda:4.7.12

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org/|g' /etc/apt/sources.list && \
    apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Actualizar conda y crear el entorno
RUN conda update -n base -c defaults conda -y && \
    conda create -n azureml python=3.10 -y

# Usar bash para que funcione conda activate
SHELL ["bash", "-c"]

# Activar entorno y realizar instalaciones en una sola capa
RUN source activate azureml && \
    pip install --upgrade pip && \
    pip install azure-ai-ml azureml-core azureml-pipeline azureml-dataprep \
                azureml-dataset-runtime azureml-defaults \
                numpy pandas scikit-learn matplotlib seaborn jupyter \
                azureml-train-automl-client mlflow && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    az extension add -n ml -y

# Configurar entorno por defecto
ENV PATH /opt/conda/envs/azureml/bin:$PATH
ENV CONDA_DEFAULT_ENV azureml

CMD ["/bin/bash"]
