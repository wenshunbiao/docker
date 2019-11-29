FROM python:2.7-slim

ENV MYCLI_VERSION 1.20.1

RUN pip install mycli==${MYCLI_VERSION}

ENTRYPOINT ["/usr/local/bin/mycli"]
CMD ["--help"]
