set env vars
set -o allexport; source .env; set +o allexport;


mkdir mysql_data
mkdir community_data
mkdir community_log
mkdir community_letsencrypt
mkdir document_data
mkdir sys
mkdir certs
mkdir es_data
mkdir document_log
mkdir document_fonts
mkdir document_forgotten
mkdir mail_data
mkdir mail_certs
mkdir mail_log
mkdir var
mkdir controlpanel_data
mkdir controlpanel_log
chown -R 1000:1000 mysql_data
chown -R 1000:1000 community_data
chown -R 1000:1000 community_log
chown -R 1000:1000 community_letsencrypt
chown -R 1000:1000 document_data
chown -R 1000:1000 sys
chown -R 1000:1000 certs
chown -R 1000:1000 es_data
chown -R 1000:1000 document_log
chown -R 1000:1000 document_fonts
chown -R 1000:1000 document_forgotten
chown -R 1000:1000 mail_data
chown -R 1000:1000 mail_certs
chown -R 1000:1000 mail_log
chown -R 1000:1000 var
chown -R 1000:1000 controlpanel_data
chown -R 1000:1000 controlpanel_log