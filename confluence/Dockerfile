FROM atlassian/confluence-server:6.6

RUN wget https://raw.githubusercontent.com/joker8023/confluence/master/crackfile/atlassian-extras-decoder-v2-3.2.jar && cp -rfp atlassian-extras-decoder-v2-3.2.jar /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar

RUN chown -R ${RUN_USER}:${RUN_GROUP} /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar

CMD ["/entrypoint.sh", "-fg"]
ENTRYPOINT ["/sbin/tini", "--"]
