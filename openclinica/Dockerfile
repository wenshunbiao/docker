FROM tomcat:7.0-jre8-alpine

RUN apk --update add wget && \
    wget --no-check-certificate https://dev.openclinica.com/distros/OpenClinica-3.11.zip && \
    unzip OpenClinica-3.11.zip && cd ./OpenClinica-3.11/distribution/ && mkdir OpenClinica && unzip OpenClinica.war -d OpenClinica && mv OpenClinica /usr/local/tomcat/webapps && rm -rf ../../OpenClinica-3.11* && \
    cd /usr/local/tomcat/webapps/OpenClinica/WEB-INF/classes/org/akaza/openclinica/i18n && \
wget -N https://raw.githubusercontent.com/ivories/openclinica/master/admin_zh.properties && \
wget -N https://raw.githubusercontent.com/ivories/openclinica/master/audit_events_zh.properties && \
wget -N https://raw.githubusercontent.com/ivories/openclinica/master/exceptions_zh.properties && \
wget -N https://raw.githubusercontent.com/ivories/openclinica/master/format_zh.properties && \
wget -N https://raw.githubusercontent.com/ivories/openclinica/master/notes_zh.properties && \
wget -N https://raw.githubusercontent.com/ivories/openclinica/master/page_messages_zh.properties && \
wget -N https://raw.githubusercontent.com/ivories/openclinica/master/terms_zh.properties && \
wget -N https://raw.githubusercontent.com/ivories/openclinica/master/words_zh.properties && \
wget -N https://raw.githubusercontent.com/ivories/openclinica/master/workflow_zh.properties && \ 
    wget -O /usr/local/tomcat/webapps/OpenClinica/WEB-INF/classes/datainfo.properties https://raw.githubusercontent.com/wnameless/docker-openclinica/master/datainfo.properties && apk del wget && rm -rf /var/cache/apk/* 

