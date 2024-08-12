set env vars
set -o allexport; source .env; set +o allexport;

sleep 240s;

# Generate the SHA-256 hash
passwordhash=$(echo -n "$ADMIN_PASSWORD" | sha256sum | awk '{print $1}')

curl "https://${WEB_URL}/ajaxpro/ASP.usercontrols_firsttime_emailandpassword_ascx,ASC.ashx" \
  -H 'accept: */*' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6,zh-CN;q=0.5,zh;q=0.4,ja;q=0.3' \
  -H 'cache-control: no-cache' \
  -H 'content-type: text/plain; charset=UTF-8' \
  -H 'pragma: no-cache' \
  -H 'priority: u=1, i' \
  -H 'x-ajaxpro-method: SaveData' \
  --data-raw "{\"email\":\"${ADMIN_EMAIL}\",\"passwordHash\":\"${passwordhash}\",\"lng\":\"en-US\",\"promocode\":null,\"amiid\":null,\"subscribeFromSite\":false}"
