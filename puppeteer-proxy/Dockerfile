FROM buildkite/puppeteer

ENTRYPOINT [""]

RUN sed -i 's@http://deb.debian.org@http://mirrors.163.com@g' /etc/apt/sources.list
RUN sed -i 's@http://security.debian.org@http://mirrors.163.com@g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    libx11-6 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxi6 \
    libxtst6 \
    libglib2.0-0 \
    libnss3 \
    libcups2 \
    libxss1 \
    libxrandr2 \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libpangocairo-1.0-0 \
    libgtk-3-0 \
    && rm -rf /var/lib/apt/lists/* \
    && cd /tmp/

RUN npm init -y && npm install express valid-url --save

ADD index.js /tmp/index.js

CMD ["node", "/tmp/index.js"]
