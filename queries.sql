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

SELECT * from animals

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

SELECT * from animals

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

-- ////Picture 4///

SELECT count(*) from animals;

SELECT count(*) from animals
WHERE escape_attempts = 0;

SELECT avg(weight_kg) from animals;

SELECT neutered, SUM(escape_attempts) AS total_escapes
	FROM animals
	GROUP BY neutered
	ORDER BY total_escapes DESC
	LIMIT 1;

SELECT species, min(weight_kg) AS min_weight, max(weight_kg) AS max_weight 
from animals
GROUP By species;

SELECT avg(escape_attempts) from animals
WHERE date_of_birth BETWEEN '1990-01-01'
and  '2000-01-01';

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
-- List of all animals that are pokemon (their type is Pokemon).
-- List all owners and their animals, remember to include those 
-- that don't own any animal.
-- How many animals are there per species?
-- List all Digimon owned by Jennifer Orwell.
-- List all animals owned by Dean Winchester that haven't tried 
-- to escape.
-- Who owns the most animals?

SELECT * from animals A LEFT JOIN owners 
ON owner_id = owners.id
WHERE full_name='Melody Pond';

SELECT * from animals LEFT JOIN species
ON species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners LEFT JOIN animals
ON owner_id = owners.id; 

SELECT species.name, count(animals.name)
FROM species JOIN animals ON species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT owners.full_name, count(animals.name)
from animals
JOIN species on animals.species_id = species.id
JOIN owners on animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' and species.name = 'Digimon'
GROUP BY owners.full_name;

-- List all animals owned by Dean Winchester that haven't tried 
-- to escape.
-- Who owns the most animals?

SELECT owners.full_name, animals.name, count(animals.name)
from animals
JOIN species on animals.species_id = species.id
JOIN owners on animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0
GROUP BY owners.full_name, animals.name;

SELECT owners.full_name, count(animals.name) as animal_num
from owners
LEFT join animals on animals.owner_id = owners.id
GROUP BY owners.full_name
order by animal_num DESC
LIMIT 1;

-- Write queries to answer the following:

-- Who was the last animal seen by William Tatcher?

SELECT * from animals
join visits on animals.id = visits.animals_id
join vets on visits.vets_id = vets.id
where vets.name = 'WILLIAM Tatcher'
order by visits.visit_date DESC
LIMIT(1);

-- How many different animals did Stephanie Mendez see?

SELECT * from animals
join visits on animals.id = visits.animals_id
join vets on visits.vets_id = vets.id
where vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.

SELECT * from vets
left join specializations on vets.id = specializations.vetss_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT * from animals
join visits on animals.id = visits.animals_id and visit_date BETWEEN '2020-04-01' and '2020-08-30'
join vets on visits.vets_id = vets.id
where vets.name = 'Stephanie Mendez';

-- What animal has the most visits to vets?

select animals.name as name, count(animals.name) as count from animals
join visits on animals.id = visits.animals_id
group by animals.name
order by count DESC
LIMIT(1);

-- Who was Maisy Smith's first visit?

SELECT * from animals
join visits on animals.id = visits.animals_id
join vets on visits.vets_id = vets.id
where vets.name = 'Maisy Smith'
order by visits.visit_date ASC
LIMIT(1);

-- Details for most recent visit: animal information, vet information, and 
-- date of visit.

Select * from visits
join animals on animals.id = visits.animals_id
join vets on visits.vets_id = vets.id
order by visits.visit_date DESC
LIMIT(1);

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT count(*) from visits
left join vets on visits.vets_id = vets.id
left join animals on visits.animals_id = animals.id
left JOIN specializations on vets.id = specializations.vetss_id and animals.species_id = specializations.speciess_id
where specializations.vetss_id is NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name, COUNT(*) AS visit_count FROM visits
JOIN animals ON visits.animals_id = animals.id
join vets on visits.vets_id = vets.id
join species on species.id = animals.species_id
where vets.name ='Maisy Smith'
GROUP BY species.name
ORDER BY visit_count DESC
LIMIT(1);