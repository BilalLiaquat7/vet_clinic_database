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