CREATE DATABASE IF NOT EXISTS cine_online CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cine_online;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Reseñas`;
DROP TABLE IF EXISTS Boletos;
DROP TABLE IF EXISTS Salas;
DROP TABLE IF EXISTS Peliculas;
DROP TABLE IF EXISTS Clientes;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Clientes (
    cliente_id      INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario  VARCHAR(50)  NOT NULL UNIQUE,
    email           VARCHAR(100) NOT NULL UNIQUE,
    telefono        VARCHAR(15),
    membresia       VARCHAR(20) NOT NULL DEFAULT 'NORMAL',
    fecha_registro  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE Peliculas (
    pelicula_id     INT AUTO_INCREMENT PRIMARY KEY,
    titulo          VARCHAR(100) NOT NULL,
    genero          VARCHAR(40),
    duracion_min    INT NOT NULL DEFAULT 90,
    clasificacion   VARCHAR(10) NOT NULL DEFAULT 'APT'
) ENGINE=InnoDB;

CREATE TABLE Salas (
    sala_id         INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sala     VARCHAR(50) NOT NULL,
    capacidad       INT NOT NULL DEFAULT 50,
    tipo_pantalla   VARCHAR(30) NOT NULL DEFAULT '2D'
) ENGINE=InnoDB;

CREATE TABLE Boletos (
    boleto_id       INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id      INT NOT NULL,
    pelicula_id     INT NOT NULL,
    sala_id         INT NOT NULL,
    precio          DECIMAL(6,2) NOT NULL DEFAULT 15.00,
    fecha_compra    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_bol_cliente FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    CONSTRAINT fk_bol_pelicula FOREIGN KEY (pelicula_id) REFERENCES Peliculas(pelicula_id),
    CONSTRAINT fk_bol_sala FOREIGN KEY (sala_id) REFERENCES Salas(sala_id)
) ENGINE=InnoDB;

CREATE TABLE `Reseñas` (
    resena_id       INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id      INT NOT NULL,
    pelicula_id     INT NOT NULL,
    calificacion    INT NOT NULL DEFAULT 5,
    comentario      TEXT,
    fecha           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_res_cliente FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    CONSTRAINT fk_res_pelicula FOREIGN KEY (pelicula_id) REFERENCES Peliculas(pelicula_id)
) ENGINE=InnoDB;

CREATE INDEX idx_boletos_cliente ON Boletos(cliente_id);
CREATE INDEX idx_resenas_pelicula ON `Reseñas`(pelicula_id);


-- =========================================================
-- BASE DE DATOS 2: veterinaria_online
-- =========================================================
CREATE DATABASE IF NOT EXISTS veterinaria_online CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE veterinaria_online;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Historial_Clinico;
DROP TABLE IF EXISTS Citas;
DROP TABLE IF EXISTS Pacientes;
DROP TABLE IF EXISTS Veterinarios;
DROP TABLE IF EXISTS `Dueños`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `Dueños` (
    `dueño_id`       INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_dueño`   VARCHAR(50) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    telefono        VARCHAR(15)
) ENGINE=InnoDB;

CREATE TABLE Veterinarios (
    veterinario_id  INT AUTO_INCREMENT PRIMARY KEY,
    nombre_vet      VARCHAR(50) NOT NULL,
    especialidad    VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE Pacientes (
    paciente_id     INT AUTO_INCREMENT PRIMARY KEY,
    `dueño_id`       INT NOT NULL,
    nombre_mascota  VARCHAR(50) NOT NULL,
    especie         VARCHAR(30) NOT NULL,
    CONSTRAINT fk_vet_dueno FOREIGN KEY (`dueño_id`) REFERENCES `Dueños`(`dueño_id`)
) ENGINE=InnoDB;

CREATE TABLE Citas (
    cita_id         INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id     INT NOT NULL,
    veterinario_id  INT NOT NULL,
    fecha_cita      DATE NOT NULL,
    CONSTRAINT fk_cita_paciente FOREIGN KEY (paciente_id) REFERENCES Pacientes(paciente_id),
    CONSTRAINT fk_cita_vet FOREIGN KEY (veterinario_id) REFERENCES Veterinarios(veterinario_id)
) ENGINE=InnoDB;

CREATE TABLE Historial_Clinico (
    historial_id    INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id     INT NOT NULL,
    diagnostico     TEXT NOT NULL,
    tratamiento     TEXT,
    CONSTRAINT fk_hist_paciente FOREIGN KEY (paciente_id) REFERENCES Pacientes(paciente_id)
) ENGINE=InnoDB;
