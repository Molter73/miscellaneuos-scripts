FROM fedora:36

RUN dnf install -y pip

COPY /requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt && \
    rm -f requirements

ENTRYPOINT [ "bash" ]
