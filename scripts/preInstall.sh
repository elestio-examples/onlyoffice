set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p "./es_data"
chown -R 1000:1000 "./es_data"

mkdir -p "app/onlyoffice/mysql/conf.d";
mkdir -p "app/onlyoffice/mysql/mysql_data";
mkdir -p "app/onlyoffice/mysql/initdb";

mkdir -p "app/onlyoffice/CommunityServer/community_data";
mkdir -p "app/onlyoffice/CommunityServer/community_log";
mkdir -p "app/onlyoffice/CommunityServer/community_letsencrypt";
mkdir -p "app/onlyoffice/CommunityServer/certs";


mkdir -p "app/onlyoffice/DocumentServer/data";
mkdir -p "app/onlyoffice/DocumentServer/logs";

mkdir -p "app/onlyoffice/MailServer/data/certs";
mkdir -p "app/onlyoffice/MailServer/logs";

mkdir -p "app/onlyoffice/ControlPanel/data";
mkdir -p "app/onlyoffice/ControlPanel/logs";

mkdir -p "sys/fs/cgroup"

echo "[mysqld]
sql_mode = 'NO_ENGINE_SUBSTITUTION'
max_connections = 1000
max_allowed_packet = 1048576000
group_concat_max_len = 2048" > ./app/onlyoffice/mysql/conf.d/onlyoffice.cnf

echo "CREATE DATABASE IF NOT EXISTS onlyoffice CHARACTER SET "utf8" COLLATE "utf8_general_ci";
CREATE DATABASE IF NOT EXISTS onlyoffice_mailserver CHARACTER SET "utf8" COLLATE "utf8_general_ci";

ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'my-secret-pw';
CREATE USER IF NOT EXISTS 'onlyoffice_user'@'%' IDENTIFIED WITH mysql_native_password BY 'onlyoffice_pass';
CREATE USER IF NOT EXISTS 'mail_admin'@'%' IDENTIFIED WITH mysql_native_password BY 'Isadmin123';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'onlyoffice_user'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'mail_admin'@'%';

FLUSH PRIVILEGES;" > ./app/onlyoffice/mysql/initdb/onlyoffice-initdb.sql

cat << EOT >> ./.env

JWT_SECRET=$(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)
EOT