set env vars
set -o allexport; source .env; set +o allexport;

sleep 240s;

password_hasher() {
local password="$1"
    
    # Run the Python script and capture the output
local hashed_password=$(python3 - <<EOF
import os
import hashlib
import binascii
import struct
import random
import uuid

def get_machine_constant():
    return os.urandom(16)

def get_machine_constant_with_bytes_count(bytes_count):
    cnst = b'\x00' * 4 + get_machine_constant()
    icnst = struct.unpack('<I', cnst[-4:])[0]
    rnd = random.Random(icnst)
    buff = bytearray(bytes_count)
    for i in range(bytes_count):
        buff[i] = rnd.randint(0, 255)

    return bytes(buff)

class PasswordHasher:
    def __init__(self):
        self.PasswordHashSize = 256
        self.PasswordHashIterations = 100000
        self.PasswordHashSalt = "941db371122e00ff905aa5f18f468a93d108b2549e77a8fe8312a44c782cd576"

        if not self.PasswordHashSalt:
            salt = hashlib.sha256(b"941db371122e00ff905aa5f18f468a93d108b2549e77a8fe8312a44c782cd576").digest()

            machine_constant = get_machine_constant_with_bytes_count(8)

            password_hash_salt_bytes = hashlib.pbkdf2_hmac(
                'sha256',
                machine_constant,
                salt,
                self.PasswordHashIterations,
                dklen=self.PasswordHashSize // 8
            )
            self.PasswordHashSalt = binascii.hexlify(password_hash_salt_bytes).decode().lower()

    def get_client_password(self, password):
        if not password.strip():
            password = str(uuid.uuid4())

        salt = self.PasswordHashSalt.encode('utf-8')

        hash_bytes = hashlib.pbkdf2_hmac(
            'sha256',
            password.encode('utf-8'),
            salt,
            self.PasswordHashIterations,
            dklen=self.PasswordHashSize // 8
        )

        return binascii.hexlify(hash_bytes).decode().lower()

hasher = PasswordHasher()
password = "$1"
hashed_password = hasher.get_client_password(password)
print(hashed_password)
EOF
)

    echo "$hashed_password"
}


passwordhash=$(password_hasher $ADMIN_PASSWORD)

curl "https://${WEB_URL}/ajaxpro/ASP.usercontrols_firsttime_emailandpassword_ascx,ASC.ashx" \
  -H 'accept: */*' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6,zh-CN;q=0.5,zh;q=0.4,ja;q=0.3' \
  -H 'cache-control: no-cache' \
  -H 'content-type: text/plain; charset=UTF-8' \
  -H 'pragma: no-cache' \
  -H 'priority: u=1, i' \
  -H 'x-ajaxpro-method: SaveData' \
  --data-raw "{\"email\":\"${ADMIN_EMAIL}\",\"passwordHash\":\"${passwordhash}\",\"lng\":\"en-US\",\"promocode\":null,\"amiid\":null,\"subscribeFromSite\":false}"