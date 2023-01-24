/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id    INT PRIMARY KEY NOT NULL,
  name          VARCHAR(250) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg     DECIMAL NOT NULL,
  COLUMN species VARCHAR(255)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(200);

CREATE TABLE owners(
  id   SERIAL PRIMARY KEY,
  full_name  VARCHAR(250) NOT NULL,
  age  INT NOT NULL
);

CREATE TABLE species(
  id   SERIAL PRIMARY KEY,
  name VARCHAR(250) NOT NULL
);

CREATE TABLE vets (
  id    SERIAL PRIMARY KEY,
  name  VARCHAR(250) NOT NULL,
  age   INT NOT NULL,
  date_of_graduation  DATE NOT NULL
);

CREATE TABLE specializations (
  vets_id INT REFERENCES vets(id),
  species_id INT REFERENCES species(id)
);

CREATE TABLE visits (
  vets_id INT REFERENCES vets(id),
  animal_id INT REFERENCES animals(id),
  date_of_visits  DATE
);

ALTER TABLE animals
DROP COLUMN id;

ALTER TABLE animals
ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);