FROM registry.access.redhat.com/ubi8/python-39:1-27

# Go to https://access.redhat.com/management/api to get a token
# and supply it as an argument.
ARG API_TOKEN
ENV API_TOKEN=${API_TOKEN}

COPY requirements.txt .

RUN pip install -r requirements.txt && \
    rm requirements.txt

COPY crawler.py .

CMD python crawler.py
