FROM apache/airflow:1.10.10-2-python3.7 as main

USER root

COPY requirements.txt .

RUN apt-get update \
    && apt-get install gcc libffi-dev python-dev libssl-dev -y libaio1 wget unzip

WORKDIR /opt/oracle
RUN wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip && \
    unzip instantclient-basiclite-linuxx64.zip && rm -f instantclient-basiclite-linuxx64.zip && \
    cd /opt/oracle/instantclient* && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci && \
    echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf && ldconfig
   
RUN pip install -r requirements.txt \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get clean \
    && apt-get update
  
USER airflow
