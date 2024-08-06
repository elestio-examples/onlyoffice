set env vars
set -o allexport; source .env; set +o allexport;

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


# mkdir mysql_data
# mkdir community_data
# mkdir community_log
# mkdir community_letsencrypt
# mkdir document_data
# mkdir sys
# mkdir certs
# mkdir es_data
# mkdir document_log
# mkdir document_fonts
# mkdir document_forgotten
# mkdir mail_data
# mkdir mail_certs
# mkdir mail_log
# mkdir var
# mkdir controlpanel_data
# mkdir controlpanel_log
# chown -R 1000:1000 mysql_data
# chown -R 1000:1000 community_data
# chown -R 1000:1000 community_log
# chown -R 1000:1000 community_letsencrypt
# chown -R 1000:1000 document_data
# chown -R 1000:1000 sys
# chown -R 1000:1000 certs
# chown -R 1000:1000 es_data
# chown -R 1000:1000 document_log
# chown -R 1000:1000 document_fonts
# chown -R 1000:1000 document_forgotten
# chown -R 1000:1000 mail_data
# chown -R 1000:1000 mail_certs
# chown -R 1000:1000 mail_log
# chown -R 1000:1000 var
# chown -R 1000:1000 controlpanel_data
# chown -R 1000:1000 controlpanel_log