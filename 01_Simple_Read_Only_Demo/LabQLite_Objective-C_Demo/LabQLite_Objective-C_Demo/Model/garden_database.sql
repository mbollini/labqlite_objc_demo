/*
 A basic plant model.
*/
CREATE TABLE plant
(
    common_name         TEXT    NOT NULL,
    common_type         TEXT,
    icon_image          BLOB,
    PRIMARY KEY (common_name)
);

/*
 A basic graden model.
*/
CREATE TABLE garden
(
    garden_name        TEXT,
    address             TEXT,
    date_added          DATE,
    PRIMARY KEY (garden_name, address)
);

/*
 A relational table that relates plants to gardens.
*/
CREATE TABLE plant_is_in_garden
(
    fk_plant_species    TEXT,
    fk_garden_name      TEXT,
    fk_garden_address   TEXT,
    count_of_plant      INTEGER,
    PRIMARY KEY (fk_plant_species, fk_garden_name, fk_garden_address),
    FOREIGN KEY (fk_plant_species) REFERENCES plant(species),
    FOREIGN KEY (fk_garden_name, fk_garden_address) REFERENCES garden(garden_name, address)
);