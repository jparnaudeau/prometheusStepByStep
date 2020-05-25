FROM docker:17.11
RUN apk add --no-cache bash ca-certificates openssl && update-ca-certificates
WORKDIR /root/

RUN apk update && \
    apk add --no-cache --virtual .build-deps && \
    apk add bash && \
    apk -Uuv add groff less python py-pip && \
    pip install awscli && \
    pip install prometheus_client && \
    pip install boto3 && \
    apk --purge -v del py-pip 

COPY scripts/randomValuesExporter.py /root/scripts/randomValuesExporter.py

CMD /root/scripts/randomValuesExporter.py
