# build and deploy on ECR a custom prometheus image
./buildAndPush.sh prometheus9099 v2.17.2

# build and deploy on ECR a custom blackbox image
./buildAndPush.sh blackbox v0.16.0

# build and deploy on ECR a custom grafana image
./buildAndPush.sh grafana 6.7.3

# build and deploy on ECR a custom grafana image
./buildAndPush.sh prometheus_reloader v1.0.0

# build and deploy on ECR a springboot app
./buildAndPush.sh springboot v1.0.0

# build and deploy on ECR a prometheus ecs discovery
./buildAndPush.sh prometheus_ecs_discovery v1.3.1

# build and deploy on ECR a custom exporter
./buildAndPush.sh custom-exporter v1.0.0

# build and deploy on ECR the alertmanager
./buildAndPush.sh alert-manager v1.0.0
