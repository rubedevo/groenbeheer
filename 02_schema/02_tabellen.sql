CREATE DATABASE IF NOT EXISTS groenbeheerdb;
USE groenbeheerdb;

-- tabel voor bomen in GIS

CREATE TABLE IF NOT EXISTS bomen(
    boom_id SERIAL PRIMARY KEY,
    boom_soort VARCHAR(25),  
    boom_locatie VARCHAR(25),   
    boom_eindbeeld VARCHAR(25),
    boom_doorwortelbareruimte INT(25),
    boom_waarde DECIMAL(65,2),
    boom_beheer VARCHAR(255),
    boom_eigenaar VARCHAR(255)
);

-- boomsoorten, heesters en vaste planten in een aparte tabel met boom_id als foreign key naar boom_soort in de tabel bomen

CREATE TABLE IF NOT EXISTS boomsoorten(
    boomsoort_id SERIAL PRIMARY KEY,
    boomsoort_genus VARCHAR(50),
    boomsoort_species VARCHAR(50),
    boomsoort_cv VARCHAR(50)
    boomsoort_grootte VARCHAR(50)
    boomsoort_soortwaarde DECIMAL(2,2),
    boomsoort_inheems BOOLEAN
    siebercode VARCHAR(5),
    licht_code VARCHAR(5),
    vocht_code INT(1)
);

-- tabel met alle heestersoorten
CREATE TABLE IF NOT EXISTS heestersoorten(
    heestersoort_id SERIAL PRIMARY KEY,
    heestersoort_genus VARCHAR(50),
    heestersoort_species VARCHAR(50),
    heestersoort_cv VARCHAR(50),
    heestersoort_grootte INT(5),
    heestersoort_inheems BOOLEAN
    heestersoort_bloeiperiode INTEGER[], --bloeiperiode wordt in een array weergegeven (1-12)
    heestersoort_bloeikleur INT,
    siebercode VARCHAR(5), 
    licht_code VARCHAR(5),
    vocht_code INT(1)
);

-- tabel met alle plantensoorten
CREATE TABLE IF NOT EXISTS plantsoorten(
    plantsoort_id SERIAL PRIMARY KEY,
    plantsoort_genus VARCHAR(50),
    plantsoort_species VARCHAR(50),
    plantsoort_cv VARCHAR(50),
    plantsoort_grootte INT(5),
    plantsoort_inheems BOOLEAN
    plantsoort_bloeiperiode INTEGER[],
    plantsoort_bloeikleur INT, -- references bloeikleur
    siebercode VARCHAR(5), -- references siebercodes
    licht_code VARCHAR(5), --references lichtcodes
    vocht_code INT(1) --references vochtcodes
);

-- tabel met mogelijke kleuren. De hexcodes zijn van belang om later een weergave te kunnen maken in html/css - Seed lookup
CREATE TABLE kleuren (
    kleur_id SERIAL PRIMARY KEY,
    kleur_naam VARCHAR(50),
    Kleur_hex CHAR(7) -- Voorbeeld: #FFD700
);

-- Tabel voor siebercodes. Andere plantentabellen refereren deze tabel - Seed lookup
CREATE TABLE IF NOT EXISTS siebercodes(
    sieber_id VARCHAR(5) PRIMARY KEY,
    sieber_omschrijving VARCHAR(100)
);

-- Tabel voor de Lichtbehoefte (Z=Zon, HS=Halfschaduw, S=Schaduw) Seed lookup
CREATE TABLE sieber_licht (
    licht_code VARCHAR(5) PRIMARY KEY,
    licht_omschrijving VARCHAR(100)
);

-- Tabel voor de Vochtbehoefte (1=droog, 2=fris, 3=nat) - Seed lookup
CREATE TABLE sieber_vocht (
    vocht_code INT(1) PRIMARY KEY,
    vocht_omschrijving VARCHAR(100)
);

-- tabel voor alle lijnvormige elementen

CREATE TABLE IF NOT EXISTS lijnen(
    lijn_id SERIAL PRIMARY KEY,
    lijn_soort VARCHAR(255),  
    lijn_locatie VARCHAR(255),   
    lijn_eindbeeld VARCHAR(255),
    lijn_beheer VARCHAR(255),
    lijn_eigenaar VARCHAR(255), 
    lijn_lengte INT(255),
    lijn_beheerintensiteit VARCHAR(255)
);

-- tabel voor alle vlakvormige elementen 
CREATE TABLE IF NOT EXISTS vlakken(
    vlak_id SERIAL PRIMARY KEY,
    vlak_cat VARCHAR (255),
    vlak_soort VARCHAR(255),  
    vlak_locatie VARCHAR(255),   
    vlak_eindbeeld VARCHAR(255),
    vlak_doorwortelbareruimte INT(255),
    vlak_waarde DECIMAL(65,2),
    vlak_beheer VARCHAR(255),
    vlak_eigenaar VARCHAR(255), 
    vlak_opp INT(255),
    vlak_beheerintensiteit VARCHAR(255)
);

-- tabel voor alle puntvormige elementen, behalve bomen (aparte shapefile/tabel)
CREATE TABLE IF NOT EXISTS punten(
    punt_id SERIAL PRIMARY KEY,
    punt_soort VARCHAR(255),  
    punt_locatie VARCHAR(255),   
    punt_eindbeeld VARCHAR(255),
    punt_doorwortelbareruimte INT(255),
    punt_waarde DECIMAL(65,2),
    punt_beheer VARCHAR(255),
    punt_eigenaar VARCHAR(255), 
    punt_beheerintensiteit VARCHAR(255)
);

-- tabel met eigenaars/beheerders => moet gelinkt worden aan export van klantenbestand
CREATE TABLE IF NOT EXISTS beheerders(
    beheerder_id SERIAL PRIMARY KEY,
    beheerder_voornaam VARCHAR(255),
    beheerder_familienaam VARCHAR(255),
    beheerder_straat VARCHAR(255),   
    beheerder_huisnr INT(4),
    beheerder_postcode INT(4),
    beheerder_gemeente VARCHAR(255),
    beheerder_tel VARCHAR(50),
    beheerder_mail VARCHAR(50) 
);

-- tabel met 1-N relaties van bomen en een boombeoordeling

CREATE TABLE IF NOT EXISTS boombeoordeling(
    boombeoordeling_id SERIAL PRIMARY KEY,
    boombeoordeling_obh INT(5),
    boombeoordeling_hoogte INT(5)
    boombeoordeling_bts INT(3),
    boombeoordeling_ohfase INT,
    boombeoordeling_groeifase INT,
    boombeoordeling_bladbezetting ENUM(0%,1-40%,40-75%,75-90%,90-100%),
    Boombeoordeling_geringescheutlengte BOOLEAN, 
    Boombeoordeling_geringebladgrootte BOOLEAN
    );

-- Onderhoudsfasen van een boom: op beeld, achterstallig, verwaarloosd, problematisch)
CREATE TABLE IF NOT EXISTS onderhoudsfasen(
    onderhoudsfase_id SERIAL PRIMARY KEY,
    onderhoudsfase_naam VARCHAR(50)
);

-- groeifasen van een boom (aanplant, jeugd, volwassen, veteraan, aftakelend, dood)
CREATE TABLE IF NOT EXISTS groeifasen(
    groeifase_id SERIAL PRIMARY KEY,
    groeifase_naam VARCHAR(50)
);

-- beheermaatregelen per groenelement. Het moet een frequentie omvatten met tijd- en materiaal-aanduiding om snel een offerte op te kunnen stellen.

CREATE TABLE IF NOT EXISTS beheermaatregelen(
    beheermaatregel_id SERIAL PRIMARY KEY,
    beheermaatregel_naam VARCHAR(50),
    beheermaatregel_materiaal VARCHAR(),
    beheermaatregel_frequentie ENUM(),
    beheermaatregel_kostprijs
    beheermaatregel_tijd
    beheermaatregel_eenheid
    beheermaatregel_machines 
    beheermaatregel_beschrijving TEXT()
);

-- 1-N relatie van beheerrondes: een element moet meerdere beheerrapporten kunnen omvatten. Het bevat op z'n minst een foto en omschrijving.
CREATE TABLE IF NOT EXISTS beheerrapporten(
    beheerrapport_id SERIAL PRIMARY KEY,
    beheerrapport_datum DATE,
    beheerrapport_maatregelen VARCHAR(255)
);
