INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
    ('Agumon', '2020-02-03', 0, TRUE, 10.23), 
    ('Gabumon', '2018-11-15', 2, TRUE, 8),
    ('Pikachu', '2021-01-07', 1, FALSE, 15.04),
    ('Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
    ('Charmander', '2020-02-08', 0, FALSE, -11), 
    ('Plantmon', '2021-11-15', 2, TRUE, -5.7),
    ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
    ('Angemon', '2005-06-12', 1, TRUE, -45),
    ('Boarmon', '2005-06-07', 7, TRUE, 20.4),
    ('Blossom', '1998-10-13', 3, TRUE, 17),
    ('Ditto', '2022-05-14', 4, TRUE, 22);

-- Insert the following data into the owners table:
-- Sam Smith 34 years old.
-- Jennifer Orwell 19 years old.
-- Bob 45 years old.
-- Melody Pond 77 years old.
-- Dean Winchester 14 years old.
-- Jodie Whittaker 38 years old.

INSERT INTO owners(full_name, age)
    VALUES
        ('Sam Smith', 34),
        ('Jennifer Orwell', 19),
        ('Bob', 45),
        ('Melody Pond', 77),
        ('Dean Winchester', 14),
        ('Jodie Whittaker', 38);

-- Insert the following data into the species table:
-- Pokemon
-- Digimon

INSERT INTO species(name)
    VALUES
        ('Digimon'),
        ('Pokemon');

UPDATE animals
    SET species_id = ( SELECT id from species WHERE name = 'Digimon')
    WHERE name like '%mon%';


UPDATE animals
    SET species_id = (SELECT id from species WHERE name = 'Pokemon')
    WHERE name NOT LIKE '%mon%';

-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.

UPDATE animals
    SET owner_id = (SELECT id from owners WHERE full_name = 'Sam Smith')
    WHERE name = 'Agumon';

UPDATE animals
    SET owner_id = (SELECT id from owners WHERE full_name = 'Jennifer Orwell')
    WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
    SET owner_id = (SELECT id from owners WHERE full_name = 'Bob')
    WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
    SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond')
    WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
    SET owner_id = (SELECT id from owners WHERE full_name = 'Dean Winchester')
    WHERE name IN ('Angemon', 'Boarmon');


-- Insert the following data for vets:
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.

INSERT INTO vets (name, age, date_of_graduation)
    VALUES 
        ('WILLIAM Tatcher', 45,'2000-04-23'),
        ('Maisy Smith',26, '2019-01-17'),
        ('Stephanie Mendez', 64, '1981-05-04'),
        ('Jack Harkness', 38, '2008-06-08');


-- Insert the following data for specializations:
    -- Vet William Tatcher is specialized in Pokemon.
    -- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
    -- Vet Jack Harkness is specialized in Digimon.

INSERT INTO specializations (speciess_id, vetss_id)
SELECT species.id, vets.id from vets
join species
on vets.name = 'WILLIAM Tatcher' and species.name = 'Pokemon';

INSERT INTO specializations (speciess_id, vetss_id)
SELECT species.id, vets.id from vets
join species
on vets.name = 'Stephanie Mendez' and species.name IN ('Pokemon', 'Digimon');

INSERT INTO specializations (speciess_id, vetss_id)
SELECT species.id, vets.id from vets
join species
on vets.name = 'Jack Harkness' and species.name IN ('Digimon');





-- Insert the following data for visits:

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-05-24' FROM vets
join animals on animals.name = 'Agumon' WHERE vets.name = 'WILLIAM Tatcher';

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-07-22' FROM vets
join animals on animals.name = 'Agumon' WHERE vets.name = 'Stephanie Mendez';

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2021-02-02' FROM vets
join animals on animals.name = 'Gabumon' WHERE vets.name = 'Jack Harkness';

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-01-05' FROM vets
join animals on animals.name = 'Pikachu' WHERE vets.name = 'Maisy Smith';

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-03-08' FROM vets
join animals on animals.name = 'Pikachu' WHERE vets.name = 'Maisy Smith';

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-05-14' FROM vets
join animals on animals.name = 'Pikachu' WHERE vets.name = 'Maisy Smith';

-- Devimon visited Stephanie Mendez on May 4th, 2021.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2021-05-04' FROM vets
join animals on animals.name = 'Devimon' WHERE vets.name = 'Stephanie Mendez';

-- Charmander visited Jack Harkness on Feb 24th, 2021.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2021-02-24' FROM vets
join animals on animals.name = 'Charmander' WHERE vets.name = 'Jack Harkness';

-- Plantmon visited Maisy Smith on Dec 21st, 2019.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2019-12-21' FROM vets
join animals on animals.name = 'Plantmon' WHERE vets.name = 'Maisy Smith';

-- Plantmon visited William Tatcher on Aug 10th, 2020.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-08-10' FROM vets
join animals on animals.name = 'Plantmon' WHERE vets.name = 'WILLIAM Tatcher';

-- Plantmon visited Maisy Smith on Apr 7th, 2021.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2021-04-07' FROM vets
join animals on animals.name = 'Plantmon' WHERE vets.name = 'Maisy Smith';

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2019-09-29' FROM vets
join animals on animals.name = 'Squirtle' WHERE vets.name = 'Stephanie Mendez';

-- Angemon visited Jack Harkness on Oct 3rd, 2020.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-10-03' FROM vets
join animals on animals.name = 'Angemon' WHERE vets.name = 'Jack Harkness';

-- Angemon visited Jack Harkness on Nov 4th, 2020.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-11-04' FROM vets
join animals on animals.name = 'Angemon' WHERE vets.name = 'Jack Harkness';

-- Boarmon visited Maisy Smith on Jan 24th, 2019.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2019-01-24' FROM vets
join animals on animals.name = 'Boarmon' WHERE vets.name = 'Maisy Smith';

-- -- Boarmon visited Maisy Smith on May 15th, 2019.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2019-05-15' FROM vets
join animals on animals.name = 'Boarmon' WHERE vets.name = 'Maisy Smith';

-- -- Boarmon visited Maisy Smith on Feb 27th, 2020.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-02-27' FROM vets
join animals on animals.name = 'Boarmon' WHERE vets.name = 'Maisy Smith';

-- -- Boarmon visited Maisy Smith on Aug 3rd, 2020.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-08-03' FROM vets
join animals on animals.name = 'Boarmon' WHERE vets.name = 'Maisy Smith';

-- -- Blossom visited Stephanie Mendez on May 24th, 2020.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2020-05-24' FROM vets
join animals on animals.name = 'Blossom' WHERE vets.name = 'Stephanie Mendez';

-- -- Blossom visited William Tatcher on Jan 11th, 2021.

INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, '2021-01-11' FROM vets
join animals on animals.name = 'Blossom' WHERE vets.name = 'WILLIAM Tatcher';