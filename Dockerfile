FROM continuumio/miniconda:4.7.12

RUN apt install -y curl

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
