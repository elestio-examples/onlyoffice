set -o allexport; source .env; set +o allexport;

    # "PasswordHashSize": 256,
    # "PasswordHashIterations": 100000,
    # "PasswordHashSalt": "941db371122e00ff905aa5f18f468a93d108b2549e77a8fe8312a44c782cd576"
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

# Example usage
result=$(password_hasher $ADMIN_PASSWORD)
echo "Hashed password: $result"