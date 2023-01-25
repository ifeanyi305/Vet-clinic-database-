CREATE DATABASE clinic;

CREATE TABLE patients (
  id     INT  GENERATED ALWAYS AS IDENTITY,
  name   VARCHAR(200) NOT NULL,
  date_of_birth   DATE NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE Medical_history (
  id     INT  GENERATED ALWAYS AS IDENTITY,
  admitted_at  TIMESTAMP,
  status   VARCHAR(200) NOT NULL,
  PRIMARY KEY(id),
  patient_id  INT,
  CONSTRAINT medical_fk 
  FOREIGN KEY(patient_id)
  REFERENCES patients(id)
  ON DELETE CASCADE,
  INDEX (patient_id)
);

CREATE TABLE Invoices (
  id     INT  GENERATED ALWAYS AS IDENTITY,
  total_amount  DECIMAL NOT NULL,
  generated_at  TIMESTAMP,
  payed_at      TIMESTAMP,
  PRIMARY KEY(id),
  medical_history_id  INT,
  CONSTRAINT invoice_fk 
  FOREIGN KEY(medical_history_id)
  REFERENCES Medical_history(id)
  ON DELETE CASCADE,
  INDEX (medical_history_id)
);

CREATE TABLE treatment (
  id     INT  GENERATED ALWAYS AS IDENTITY,
  type   VARCHAR(200) NOT NULL,
  name   VARCHAR(200) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE invoice_items (
  id     INT  GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL NOT NULL,
  quantity  INT NOT NULL,
  total_price  DECIMAL NOT NULL,
  invoice_id    INT,
  treatment_id  INT,
  CONSTRAINT invoice_item_fk 
  FOREIGN KEY(invoice_id)
  REFERENCES Invoices(id)
  ON DELETE CASCADE,
  CONSTRAINT treatment_fk
  FOREIGN KEY(treatment_id)
  REFERENCES treatment(id)
  ON DELETE CASCADE,
  PRIMARY KEY(id),
  INDEX (invoice_id, treatment_id) 
);

