##########################
# Tag variables
###########################
environment = "sandbox"
application = "ippevent"
owner       = "jparnaudeau"

additional_tags = {
    Component = "pi"
    Stack = "pi-calculation"
}

###########################
# ASG - Variables
###########################
min_size      = 3
max_size      = 3
service_name  = "pi-calculation"
