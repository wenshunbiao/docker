FROM wenshunbiao/php

RUN apk add --no-cache supervisor

WORKDIR /app
ENTRYPOINT [""]
CMD /usr/bin/supervisord -c /supervisor/supervisord.conf -n
