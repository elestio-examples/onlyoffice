#!/bin/bash

# Export environment variables
export SOFTWARE_VERSION_TAG="12.0.1.1748"
export MYSQL_ROOT_PASSWORD="random_password"
export ONLYOFFICE_CORE_MACHINEKEY="core_secret"
export CONTROL_PANEL_PORT_80_TCP="80"
export CONTROL_PANEL_PORT_80_TCP_ADDR="onlyoffice-control-panel"
export MYSQL_SERVER_ROOT_PASSWORD="random_password"
export MYSQL_SERVER_DB_NAME="onlyoffice"
export MYSQL_SERVER_HOST="onlyoffice-mysql-server"
export MYSQL_SERVER_USER="onlyoffice_user"
export MYSQL_SERVER_PASS="onlyoffice_pass"
export ELASTICSEARCH_SERVER_HOST="onlyoffice-elasticsearch"
export ELASTICSEARCH_SERVER_HTTPPORT="9200"
export discovery_type="single-node"
export bootstrap_memory_lock="true"
export ES_JAVA_OPTS="-Xms1g -Xmx1g -Dlog4j2.formatMsgNoLookups=true"
export indices_fielddata_cache_size="30%"
export indices_memory_index_buffer_size="30%"
export ingest_geoip_downloader_enabled="false"

# Run docker-compose
docker-compose up -d
