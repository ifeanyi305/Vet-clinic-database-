/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES 
(1, 'Agumon', '2020-02-03', 0, 'TRUE', 10.23),
(2, 'Gabumon', '2018-11-15', 2, 'TRUE', 8),
(3, 'Pikachu', '2021-01-07', 1, 'FALSE', 15.04),
(4, 'Devimon', '2017-05-12', 5, 'TRUE', 11),
(5, 'Charmander', '2020-02-08', 0, 'FALSE', -11),
(6, 'Plantmon', '2021-11-15', 2, 'TRUE', -5.7),
(7, 'Squirtle', '1993-04-02', 3, 'FALSE', -12.13),
(8, 'Angemon', '2005-06-12', 1, 'TRUE', -45),
(9, 'Boarmon', '2005-06-07', 7, 'TRUE', 20.4),
(10, 'Blossom', '1998-10-13', 3, 'TRUE', 17),
(11, 'Ditto', '2022-05-14', 4, 'TRUE', 22);

INSERT INTO owners (full_name, age)
VALUES 
('Sam Smith', 34),
('Jennifer', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');

UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');


INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
(' Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');


INSERT INTO specializations (vets_id, species_id) VALUES 
(1, 1),
(2, 2),
(3, 1),
(4, 2);


INSERT INTO visits (animal_id, vets_id, date_of_visits) VALUES
(1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(5, 2, '2020-01-05'),
(5, 2, '2020-03-08'),
(5, 2, '2020-05-14'),
(3, 3, '2021-05-04'),
(6, 4, '2021-02-14'),
(8, 2, '2019-12-21'),
(8, 1, '2020-08-10'),
(8, 2, '2021-04-21'),
(10, 3, '2019-09-29'),
(9, 4, '2020-10-03'),
(9, 4, '2020-11-04'),
(4, 2, '2019-01-24'),
(4, 2, '2019-05-15'),
(4, 2, '2020-02-27'),
(4, 2, '2020-08-03'),
(7, 3, '2020-05-24'),
(7, 1, '2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits
 (animal_id, vets_id, date_of_visits)
  SELECT * FROM (SELECT id FROM animals)
   animal_ids, (SELECT id FROM vets) 
   vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;