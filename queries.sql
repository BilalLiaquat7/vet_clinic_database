SELECT * from animals
WHERE name LIKE '%mon';

SELECT name from animals
WHERE 
    date_of_birth BETWEEN '2016-01-01'
and  '2019-01-01';

Select name from animals
WHERE
    neutered = TRUE and escape_attempts < 3;

Select date_of_birth from animals
WHERE
    name = 'Agumon' OR
    name = 'Pikachu';

SELECT name, escape_attempts from animals
WHERE
    weight_kg > 10.5;

SELECT * from animals
WHERE
    neutered = TRUE;

SELECT * from animals
WHERE
    name != 'Gabumon';

SELECT * from animals
WHERE
    weight_kg BETWEEN 10.4 and 17.3;

-- Inside a transaction update the animals table by setting the species column 
-- to unspecified. Verify that change was made. Then roll back the change and 
-- verify that the species columns went back to the state before the transaction.

BEGIN;
UPDATE animals
SET species = 'unspecified';

ROLLBACK;

SELECT * from animals

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all 
-- animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all 
-- animals that don't have species already set.
-- Verify that changes were made.
-- Commit the transaction.
-- Verify that changes persist after commit.
-- Take a screenshot of the results of your actions.

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name like '%mon%';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * from animals;

COMMIT;

BEGIN;
DELETE from animals;

SELECT * from animals;

ROLLBACK;

SELECT * from animals

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight 
-- multiplied by -1.
-- Commit transaction
-- Take a screenshot of the results of your actions.

BEGIN;
DELETE FROM animals 
WHERE date_of_birth > '2022-01-01';

SELECT * from animals;

SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * (-1);

SELECT * from animals;

ROLLBACK TO SAVEPOINT sp1;

UPDATE animals
SET weight_kg = weight_kg* (-1)
WHERE weight_kg < 0;

SELECT * from animals;

Commit;

SELECT * from animals