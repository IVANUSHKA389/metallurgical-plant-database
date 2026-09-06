CREATE SCHEMA IF NOT EXISTS metallurgicheskiyzavod;
SET search_path TO metallurgicheskiyzavod;

CREATE TABLE Zavod (
    cod_zavod INT PRIMARY KEY,
    name_zavod VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(20)
);

CREATE TABLE Ceh (
    cod_ceh INT PRIMARY KEY,
    name_ceh VARCHAR(100) NOT NULL,
    spec_ceh VARCHAR(50),
    cod_zavod INT NOT NULL REFERENCES Zavod(cod_zavod)
);

CREATE TABLE Oborudovanie (
    cod_obor INT PRIMARY KEY,
    name_obor VARCHAR(100) NOT NULL,
    type_obor VARCHAR(50),
    date_vvoda DATE,
    cod_ceh INT NOT NULL REFERENCES Ceh(cod_ceh)
);

CREATE TABLE Sotrudnik (
    cod_sotr INT PRIMARY KEY,
    fio VARCHAR(100) NOT NULL,
    dolzhnost VARCHAR(50),
    tab_nom VARCHAR(20) UNIQUE,
    cod_ceh INT NOT NULL REFERENCES Ceh(cod_ceh)
);

CREATE TABLE Syrye (
    cod_syrye INT PRIMARY KEY,
    name_syrye VARCHAR(100) NOT NULL,
    ed_izm VARCHAR(10)
);

CREATE TABLE Material (
    cod_mat INT PRIMARY KEY,
    name_mat VARCHAR(100) NOT NULL,
    ed_izm VARCHAR(10)
);

CREATE TABLE Produkt (
    cod_produkt INT PRIMARY KEY,
    name_produkt VARCHAR(100) NOT NULL,
    gost VARCHAR(30),
    ed_izm VARCHAR(10)
);

CREATE TABLE Operatsiya (
    cod_op INT PRIMARY KEY,
    name_op VARCHAR(100) NOT NULL,
    opis VARCHAR(255),
    cod_ceh INT NOT NULL REFERENCES Ceh(cod_ceh)
);

CREATE TABLE Syrye_v_op (
    cod_syrye INT NOT NULL REFERENCES Syrye(cod_syrye),
    cod_op INT NOT NULL REFERENCES Operatsiya(cod_op),
    rashod_na_1t DECIMAL(10,3),
    PRIMARY KEY (cod_syrye, cod_op)
);

CREATE TABLE Material_v_op (
    cod_mat INT NOT NULL REFERENCES Material(cod_mat),
    cod_op INT NOT NULL REFERENCES Operatsiya(cod_op),
    rashod_na_1t DECIMAL(10,3),
    PRIMARY KEY (cod_mat, cod_op)
);

CREATE TABLE Vypusk (
    cod_vypusk INT PRIMARY KEY,
    cod_op INT NOT NULL REFERENCES Operatsiya(cod_op),
    cod_produkt INT NOT NULL REFERENCES Produkt(cod_produkt),
    data_vyp DATE NOT NULL,
    massa_t DECIMAL(12,3) NOT NULL
);

CREATE TABLE Zakaz (
    cod_zakaz INT PRIMARY KEY,
    nomer_zakaza VARCHAR(30) UNIQUE NOT NULL,
    data_zakaza DATE NOT NULL,
    klient VARCHAR(100) NOT NULL,
    srok_postavki DATE
);

CREATE TABLE Partiya (
    cod_part INT PRIMARY KEY,
    nomer_part VARCHAR(30) UNIQUE NOT NULL,
    data_vyp DATE NOT NULL,
    cod_produkt INT NOT NULL REFERENCES Produkt(cod_produkt),
    cod_op INT REFERENCES Operatsiya(cod_op),
    cod_zakaz INT REFERENCES Zakaz(cod_zakaz),
    massa_t DECIMAL(12,3)
);

CREATE TABLE Kontrol_kachestva (
    cod_kk INT PRIMARY KEY,
    nomer_protokola VARCHAR(30) UNIQUE,
    data_kk DATE NOT NULL,
    cod_part INT NOT NULL REFERENCES Partiya(cod_part),
    prochnost_MPa DECIMAL(6,2),
    him_sostav TEXT,
    pass_fail BOOLEAN NOT NULL
);

CREATE TABLE Zakaz_Produkt (
    cod_zakaz INT NOT NULL REFERENCES Zakaz(cod_zakaz),
    cod_produkt INT NOT NULL REFERENCES Produkt(cod_produkt),
    kolvo_t DECIMAL(12,3) NOT NULL,
    PRIMARY KEY (cod_zakaz, cod_produkt)
);

CREATE TABLE Perevozchik (
    cod_perev INT PRIMARY KEY,
    name_perev VARCHAR(100) NOT NULL,
    type_perev VARCHAR(30),
    contact VARCHAR(100)
);

CREATE TABLE Otgruzka (
    cod_otgr INT PRIMARY KEY,
    cod_zakaz INT NOT NULL REFERENCES Zakaz(cod_zakaz),
    cod_perev INT NOT NULL REFERENCES Perevozchik(cod_perev),
    data_otgr DATE NOT NULL,
    massa_t DECIMAL(12,3),
    nomer_nakladnoi VARCHAR(30)
);

CREATE INDEX IF NOT EXISTS idx_vypusk_data ON Vypusk(data_vyp);
CREATE INDEX IF NOT EXISTS idx_zakaz_nomer ON Zakaz(nomer_zakaza);
