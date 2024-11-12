#!/bin/bash

# Paths to YAML files
TELEGRAF_POD_YAML="./podman/telegraf-pod.yaml"
INFLUXDB_POD_YAML="./podman/influxdb-pod.yaml"
GRAFANA_POD_YAML="./podman/grafana-pod.yaml"
VOLUMES_YAML="./podman/persistent-volumes.yaml"

# Start the TIG stack
start_all() {
    echo -e "\n############### \e[1;30;42mStarting the TIG Stack\e[0m ###############\n"
    podman kube play "$INFLUXDB_POD_YAML"
    podman kube play "$TELEGRAF_POD_YAML"
    podman kube play "$GRAFANA_POD_YAML"
    echo -e "\n############### \e[1;30;42mTIG stack started\e[0m ###############\n"
    podman ps -a
}

# Stop the TIG stack
stop_all() {
    echo -e "\n############### \e[1;30;42mTearing down the TIG stack\e[0m ###############\n"
    podman kube play "$TELEGRAF_POD_YAML" --down
    podman kube play "$GRAFANA_POD_YAML" --down
    podman kube play "$INFLUXDB_POD_YAML" --down
    echo -e "\n############### \e[1;30;42mTIG stack stopped & removed\e[0m ###############\n"
    podman ps -a
}

# Create volumes
create_volumes() {
    echo -e "\n############### \e[1;30;42mCreating InfluxDB & Grafana volumes\e[0m ###############\n"
    podman kube play "$VOLUMES_YAML"
    echo -e "\n############### \e[1;30;42mVolumes created\e[0m ###############\n"
    podman volume ls
}

# Delete volumes
delete_volumes() {
    echo -e "\n############### \e[1;30;42mDeleting InfluxDB & Grafana volumes\e[0m ###############\n"
    podman volume rm grafana-data-pvc
    podman volume rm influxdb-data-pvc
    echo -e "\n############### \e[1;30;42mVolumes deleted\e[0m ###############\n"
    podman volume ls
}

# Perform full deployment
deploy() {
    create_volumes
    start_all
}

destroy() {
    stop_all
    delete_volumes
}

# Display help message
display_help() {
    echo "Usage: $0 {start|stop|create_vol|del_vol|deploy|destroy}"
    echo
    echo "Commands:"
    echo "  start       Start all pods defined in the YAML files (Telegraf, InfluxDB, Grafana)."
    echo "  stop        Stop and remove all running pods (Telegraf, InfluxDB, Grafana)."
    echo "  create_vol  Create InfluxDB and grafana volumes from YAML file."
    echo "  del_vol     Delete InfluxDB and grafana volumes."
    echo "  deploy      Perform full TIG stack deployment."
    echo "  destroy     Destroy full TIG stack and volumes."
    echo "  help        Display this help message."
}

# Main
case "$1" in
    start)
        start_all
        ;;
    stop)
        stop_all
        ;;
    create_vol)
        create_volumes
        ;;
    del_vol)
        delete_volumes
        ;;
    deploy)
        deploy
        ;;
    destroy)
        destroy
        ;;
    help)
        display_help
        ;;
    *)
        echo "Usage: $0 {start|stop|create_vol|del_vol|deploy|destroy}"
        exit 1
        ;;
esac

