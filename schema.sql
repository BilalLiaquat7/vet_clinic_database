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



CREATE TABLE vets (
    id SERIAL primary Key NOT NULL,
    name varchar(50),
    age INT,
    date_of_graduation date
);

CREATE TABLE specializations (
    speciess_id INT,
    vetss_id INT,
    CONSTRAINT fk_speciess_id FOREIGN KEY (speciess_id) REFERENCES species(id),
    CONSTRAINT fk_vetss_id FOREIGN KEY (vetss_id) REFERENCES vets(id)
);

CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    visit_date date,
    CONSTRAINT fk_animals_id FOREIGN KEY (animals_id) REFERENCES animals(id),
    CONSTRAINT fk_vets_id FOREIGN KEY (vets_id) REFERENCES vets(id),
);

ALTER TABLE specializations ADD Primary Key (speciess_id, vetss_id);