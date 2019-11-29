#FROM alpine
FROM centos

#RUN apk --update add python py-pip py-crypto unzip curl bash && \
#    pip install --upgrade pip && pip install rpyc pefile pyyaml && \
#    curl -o /pupy.zip https://codeload.github.com/n1nj4sec/pupy/zip/master && \
#    unzip /pupy.zip && mv /pupy-master /pupy && rm /pupy.zip && \
#    apk del unzip curl && rm -rf /var/cache/apk/*

RUN yum update -y && yum install -y python-devel python python-crypto unzip python-setuptools gcc openssl openssl-devel&& \
    curl -o /pupy.zip https://codeload.github.com/n1nj4sec/pupy/zip/master && \
    cd / && unzip /pupy.zip && mv /pupy-master /pupy && rm /pupy.zip && \
    curl -o /pip.tar.gz https://codeload.github.com/pypa/pip/tar.gz/9.0.1 && \
    tar zxvf /pip.tar.gz && cd /pip-9.0.1 && python setup.py install && \
    pip install -r /pupy/requirements.txt && rm -rf /pip.tar.gz && \
    curl -o /pupy/pupy/payload_templates/b.zip https://codeload.github.com/n1nj4sec/pupy-binaries/zip/master && cd /pupy/pupy/payload_templates && unzip b.zip && \
    mv pupy-binaries-master/* ./ && rm -rf b.zip && \
    yum remove -y python-devel unzip python-setuptools gcc && yum clean all

WORKDIR /pupy/pupy
CMD /bin/bash
