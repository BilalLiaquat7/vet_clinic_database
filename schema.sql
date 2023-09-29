CREATE DATABASE vet_clinic

CREATE TABLE animals (
    id SERIAL PRIMARY KEY NOT NULL,
    name char(35),
    date_of_birth date,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals
    ADD species char(35);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT,
ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id),
ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id);