/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Start transaction */

BEGIN;

/* update transaction */

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

/* Start transaction */

BEGIN;

/* update transaction */

UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals 
SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;

/* Commit the transaction */
COMMIT;
SELECT * FROM animals;

/* Start transaction */

BEGIN;
/* Delete a transaction */
DELETE FROM animals;
/* Return to previuse state of transation */
ROLLBACK;
SELECT * FROM animals;

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

/* CREATE A SAVEPOINT FOR WEIGHT_KG COLUMN */

SAVEPOINT weight_kg;

UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

/* Return back to savepoint */
ROLLBACK TO weight_kg;
SELECT * FROM animals;

UPDATE animals
SET weight_kg = weight_kg * -1 
WHERE weight_kg < 0;
SELECT * FROM animals;

/* Commit the transaction */
COMMIT;
SELECT * FROM animals;

/* Start transaction */
BEGIN;
/* COUNT NUMBER OF ANIMALS */
SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species; 

/* Commit the transaction */
COMMIT;
SELECT * FROM animals;

SELECT name FROM animals JOIN owners ON  owners.id = owner_id
WHERE full_name = 'Melody Pond';

SELECT * FROM animals JOIN species s ON species_id = s.id
WHERE s.name = 'Pokemon';

SELECT full_name AS owner, name AS pet FROM animals a
FULL JOIN owners o ON o.id = a.owner_id;

SELECT COUNT(a.name), s.name FROM animals a JOIN species s ON species_id = s.id
GROUP BY s.name;

SELECT a.name FROM animals a 
LEFT JOIN owners o ON o.id = a.owner_id
LEFT JOIN species s ON s.id = a.species_id
WHERE o.full_name = 'Jennifer' AND s.name = 'Digimon';

SELECT * FROM animals a
FULL JOIN owners o ON o.id = owner_id
WHERE o.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT owner FROM (
  SELECT COUNT(a.name) as count, full_name as owner FROM animals a
  JOIN owners o ON o.id = owner_id
  GROUP BY owner
) AS animals_per_owner
WHERE count = (SELECT MAX(count) FROM (
  SELECT COUNT(a.name) as count, full_name as owner FROM animals a
  JOIN owners o ON o.id = owner_id
  GROUP BY owner
) AS animals_per_owner);

SELECT a.name, a.species_id, v.date_of_visits FROM animals a 
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vets_id = ve.id
WHERE ve.name = 'William Tatcher'
ORDER BY v.date_of_visits DESC
LIMIT 1;
-- DESC is a shorthand for descending order and ASC for ascending order

SELECT COUNT(DISTINCT animal_id) FROM visits WHERE vets_id = 3;

SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id WHERE visits.vets_id = 3 AND visits.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animal_id, count(*) from visits group by animal_id order by count(animal_id) desc limit 1;

SELECT vets.name FROM vets JOIN visits ON vets.id = visits.vets_id WHERE visits.animal_id = 2 ORDER BY visits.date_of_visits LIMIT 1;

SELECT animals.name, vets.name, visits.date_of_visits FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vets_id = vets.id ORDER BY visits.date_of_visits DESC LIMIT 1;

SELECT COUNT(visits.animal_id) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vets_id = vets.id LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id WHERE species.id != animals.species_id;

SELECT species_id from animals where id = (select animal_id from visits where vets_id = 2 group by animal_id order by count(animal_id) desc limit 1); 


SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vets_id = 2;
SELECT * FROM owners where email = 'owner_ 18327@mail.com';

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
