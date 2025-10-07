FROM continuumio/miniconda:4.7.12

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh

RUN conda create -n azureml python=3.10 -y && conda activate azureml

RUN pip install azure-ai-ml azureml-core azureml-pipeline azureml-dataprep azureml-dataset-runtime azureml-defaults

RUN pip install numpy pandas scikit-learn matplotlib seaborn jupyter azureml-train-automl-client mlflow

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN az extension add -n ml -y