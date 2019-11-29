FROM python:3.6

RUN apt-get update && apt-get -y install git python3-dev python3-pip libleveldb-dev libssl-dev screen

RUN git clone https://github.com/CityOfZion/neo-python.git

WORKDIR /neo-python
RUN git checkout development

RUN pip3 install -r requirements.txt

RUN rm -rf /neo-python/Chains/SC234/

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
   
#ENTRYPOINT ["/entrypoint.sh"]
CMD ["/entrypoint.sh"]
