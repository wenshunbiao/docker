FROM ivories/tensorflow:1.0

RUN apk add --no-cache build-base python3-dev && \
    pip3 --no-cache-dir install -U nltk tqdm django asgi_redis channels && python3 -m nltk.downloader punkt && \
    apk del build-base python3-dev && rm -rf /var/cache/apk/*

RUN apk add --no-cache openssl && wget https://github.com/Conchylicultor/DeepQA/archive/master.zip && unzip master.zip && rm master.zip && mv DeepQA-master DeepQA

WORKDIR /DeepQA/chatbot_website

ENV CHATBOT_SECRET_KEY="e#0y6^6mg37y9^+t^p_$xwnogcdh=27)f6_=v^$bh9p0ihd-%v"
ENV CHATBOT_REDIS_URL="redis"

EXPOSE 8000

RUN sed -i "s#ALLOWED_HOSTS = \[\]#ALLOWED_HOSTS = \['*'\]#g" /DeepQA/chatbot_website/chatbot_website/settings.py
RUN cat /DeepQA/chatbot_website/chatbot_website/settings.py

RUN python3 manage.py makemigrations
RUN python3 manage.py migrate

CMD python3 manage.py runserver 0.0.0.0:8000
