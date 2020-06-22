FROM apache/airflow:1.10.10-2-python3.7 as main

USER root

COPY requirements.txt .

RUN apt-get update \
    && apt-get install gcc libffi-dev python-dev libssl-dev -y \
    && apt-get clean \
    && apt-get update 

RUN pip install -r requirements.txt \
    && rm -rf /var/lib/apt/lists/*

USER airflow
