set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p "app/onlyoffice/mysql/conf.d"
mkdir -p "app/onlyoffice/mysql/data"
mkdir -p "app/onlyoffice/mysql/initdb"

mkdir -p "app/onlyoffice/CommunityServer/data"
mkdir -p "app/onlyoffice/CommunityServer/logs"
mkdir -p "app/onlyoffice/CommunityServer/letsencrypt"

mkdir -p "app/onlyoffice/DocumentServer/data"
mkdir -p "app/onlyoffice/DocumentServer/logs"

mkdir -p "app/onlyoffice/MailServer/data/certs"
mkdir -p "app/onlyoffice/MailServer/logs"

mkdir -p "app/onlyoffice/ControlPanel/data"
mkdir -p "app/onlyoffice/ControlPanel/logs"


echo "CREATE USER 'onlyoffice_user'@'localhost' IDENTIFIED BY 'onlyoffice_pass';
CREATE USER 'mail_admin'@'localhost' IDENTIFIED BY 'Isadmin123';
GRANT ALL PRIVILEGES ON * . * TO 'root'@'%' IDENTIFIED BY 'my-secret-pw';
GRANT ALL PRIVILEGES ON * . * TO 'onlyoffice_user'@'%' IDENTIFIED BY 'onlyoffice_pass';
GRANT ALL PRIVILEGES ON * . * TO 'mail_admin'@'%' IDENTIFIED BY 'Isadmin123';
FLUSH PRIVILEGES;" > /app/onlyoffice/mysql/initdb/setup.sql


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