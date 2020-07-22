FROM apache/airflow:1.10.10-2-python3.7 as main

USER root

RUN apt-get update \
    && apt-get install gcc libffi-dev python-dev libssl-dev -y libaio1 wget unzip

WORKDIR /opt/oracle
RUN wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip \
    && unzip instantclient-basiclite-linuxx64.zip \
    && rm -f instantclient-basiclite-linuxx64.zip && \
    cd /opt/oracle/instantclient* \
    && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci \
    && echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf \
    && ldconfig \
    && apt-get clean \
    && apt-get update
  
WORKDIR ${AIRFLOW_HOME}

COPY requirements.txt .

RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && rm -rf /var/lib/apt/lists/*

# Create and grant access to repository folder
RUN mkdir -pv "${AIRFLOW_HOME}/repository"; \
    && chown -R "airflow:root" "${AIRFLOW_USER_HOME_DIR}" "${AIRFLOW_HOME}"; 

USER airflow
