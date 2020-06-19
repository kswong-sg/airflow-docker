FROM apache/airflow:1.10.10-2-python3.7 as main

USER root

RUN apt-get update \
    && apt-get install gcc libffi-dev python-dev libssl-dev -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER airflow
