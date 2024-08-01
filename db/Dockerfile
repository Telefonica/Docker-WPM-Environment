FROM postgres:14.2

RUN apt update && apt install -y --no-install-recommends \
    python3 \
    python3-pip \
    postgresql-plpython3-14 \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir latch-sdk-telefonica

COPY triggers_template.sql triggers_template.sql
COPY install.py install.py
