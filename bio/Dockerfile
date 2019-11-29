FROM ivories/spark:1.0

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.3/main/" > /etc/apk/repositories

RUN apk add --update --no-cache build-base zlib-dev perl boost boost-dev && \
    curl -o bowtie2-2.2.9.tar.gz https://codeload.github.com/BenLangmead/bowtie2/tar.gz/v2.2.9 ; \
    tar zxvf bowtie2-2.2.9.tar.gz && cd bowtie2-2.2.9 && make -j && make install && cd .. && rm -rf bowtie* && \
    curl -SLo tophat-2.1.1.tar.gz https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.tar.gz && \
    tar zxvf tophat-2.1.1.tar.gz && cd tophat-2.1.1 && \
    sed -i "s/PAGESIZE/PAGESIZE_1/g" src/SeqAn-1.4.2/seqan/file/file_page.h && \
    sed -i "s/PAGESIZE/PAGESIZE_1/g" src/SeqAn-1.4.2/seqan/file/string_external.h && \
    ./configure && make && make install && cd .. && rm -rf tophat* && \
    apk del boost-dev build-base && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]

