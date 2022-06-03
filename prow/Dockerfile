FROM fedora:36

COPY /requirements.txt /requirements.txt

RUN dnf install -y pip && \
    pip install --no-cache-dir -r /requirements.txt && \
    rm -f requirements

ENTRYPOINT [ "bash" ]
