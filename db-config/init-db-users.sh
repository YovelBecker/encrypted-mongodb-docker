#!/bin/sh
set -e

mongo <<EOF
use admin

db.createUser(
  {
    user: "MyUserAdmin",
    pwd: "$DB_ADMIN_PASS",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
  }
)
EOF

mongo --port 27017  --authenticationDatabase "admin" -u "MyUserAdmin" -p "$DB_ADMIN_PASS" <<EOF
use tara-web
db.createUser(
  {
    user: "$DB_USERNAME",
    pwd:  "$DB_PASS",
    roles: [ { role: "readWrite", db: "tara-web" }]
  }
)
EOF