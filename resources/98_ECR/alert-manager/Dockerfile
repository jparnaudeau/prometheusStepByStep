FROM prom/alertmanager

USER root

COPY ./alertmanager.yml /etc/alertmanager/alertmanager.yml
COPY ./entrypoint.sh /etc/entrypoint.sh
COPY ./templates/*.tmpl /templates/

ENTRYPOINT ["/etc/entrypoint.sh"]
