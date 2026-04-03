# Groenbeheer Informatie Systeem (GBIS)

Dit project is een schaalbaar, postgresql database-gestuurd systeem voor de inventarisatie en het beheer van bomen, heesters en vaste planten. Het combineert de kracht van PostGIS, QGIS en QField met een professionele software development workflow.

## Tech Stack
Database: PostgreSQL met PostGIS extensie (Geospatiale opslag & logica).

Editor: VS Code (SQL-ontwikkeling & versiebeheer).

Versiebeheer: Git & GitHub (Infrastructure as Code).

Desktop GIS: QGIS (Data styling, formulierontwerp & rapportage).

Field App: QField + QField Cloud (Mobiele data-acquisitie via GPS).

## Project structuur
├── database/
│   ├── 01_init.sql          # Database creatie & extensies
│   ├── 02_tables.sql        # Definities van features en soortenlijsten
│   ├── 03_constraints.sql   # Relaties (FK) en data-integriteit
│   ├── 04_views.sql         # Beheerplanning en rapportage-views
│   └── /seeds               # CSV/SQL bestanden van plantendatabases
├── gis/
│   ├── project.qgs          # Hoofd QGIS projectbestand
│   └── /styles              # QML bestanden voor symboolweergave
├── docs/                    # Handleidingen en veldinstructies
└── README.md                # Project roadmap en documentatie
## Roadmap

### Fase 1: Het "Walking Skeleton" (MVP) 🏗️
[ ] Repository initialiseren en mappenstructuur opzetten.

[ ] PostgreSQL database lokaal configureren met PostGIS.

[ ] Basis-tabel inventaris_punten aanmaken in SQL.

[ ] Eerste synchronisatie tussen QGIS en QField Cloud succesvol afronden.

### Fase 2: Datamodel & Nomenclatuur 🌿
[ ] Externe planten- en bomendatabases importeren als lookup-tabellen.

[ ] Foreign Keys implementeren tussen inventaris en soortenlijsten.

[ ] Invoerformulieren in QGIS optimaliseren met Dropdown-menu's (Value Relations).

### Fase 3: Beheerlogica & Planning 📅
[ ] SQL Views aanmaken voor de "Beheer-kalender".

[ ] Triggers implementeren voor automatische update-timestamps.

[ ] Ontwikkelen van beheerrapportages via QGIS Atlas.

### Fase 4: Professionalisering 🚀
[ ] Integratie van hoge-precisie GPS (RTK) instellingen in QField.

[ ] Implementeren van migratie-scripts voor schema-updates.

[ ] Dashboards maken voor de voortgang van het terreinbeheer.
