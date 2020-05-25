##########################
# Tag variables
###########################
environment = "sandbox"
application = "ippevent"
owner       = "jparnaudeau"

additional_tags = {
    Component = "monitoring"
    Stack = "prometheus"
}

###########################
# Reload - Variables
###########################
prometheus_url = "http://ippenvent-prometheus.sbx.aws.ippon.fr:9090/reload"

