#!/bin/bash

service_name="Apache"

# Captura o timestamp atual e ajusta para UTC-3 (subtraindo 3 horas)
timestamp=$(date -d "-3 hours" +"%Y-%m-%d %H:%M:%S")

if systemctl is-active httpd; then
    echo "Data/Hora: $timestamp - $service_name - Serviço HTTPD - Status: O serviço está online" >> "/mnt/nfs/valmir/httpd-online.txt"
else
    echo "Data/Hora: $timestamp - $service_name - Serviço HTTPD - Status: O serviço está offline" >> "/mnt/nfs/valmir/httpd-offline.txt"
fi

