#!/bin/bash
DB_NAME="groenbeheerdb"
USER="rubdev"

echo "--- Start Database Setup voor $DB_NAME ---"
echo "Actie: Bestanden inlezen..."

# Ga naar de projectmap en voer uit:
for file in 01_setup/*.sql; do
    echo "Bezig met verwerken van $file..."
    psql -U $USER -d $DB_NAME -f "$file" || exit 1
done

02_schema/02_tabellen.sql

echo "Klaar! Je bent nu ingelogd op $DB_NAME."
psql -U $USER -d $DB_NAME