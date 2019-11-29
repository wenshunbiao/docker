FROM sequenceiq/spark:1.6.0

# Installs bowtie from compiled distribution into /opt/bowtie
#ENV BOWTIE_URL=http://sourceforge.net/projects/bowtie-bio/files/bowtie
ENV BOWTIE_URL=http://sourceforge.net/projects/bowtie-bio/files/bowtie2
ENV BOWTIE_RELEASE=2.2.9
ENV DEST_DIR=/opt

# Download Bowtie, unzip it and remove .zip file
RUN curl -SLo ${DEST_DIR}/bowtie2-${BOWTIE_RELEASE}.zip ${BOWTIE_URL}/${BOWTIE_RELEASE}/bowtie2-${BOWTIE_RELEASE}-source.zip && unzip ${DEST_DIR}/bowtie2-${BOWTIE_RELEASE}.zip -d ${DEST_DIR} && rm ${DEST_DIR}/bowtie2-${BOWTIE_RELEASE}.zip

# Add bowtie path to the enviroment
ENV PATH=${DEST_DIR}/bowtie2-${BOWTIE_RELEASE}:$PATH

CMD ["bowtie2"]
