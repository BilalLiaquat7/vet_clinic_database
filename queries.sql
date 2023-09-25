SELECT * from animals
WHERE name LIKE '%mon';

SELECT * from animals
WHERE 
    date_of_birth BETWEEN '2016-01-01'
and  '2019-01-01';

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