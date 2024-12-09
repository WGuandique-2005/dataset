create database datawarehouse;
use datawarehouse;

-- Tabla de Áreas (por ejemplo, farmacia, administración, etc.)
CREATE TABLE area (
    id_area INT PRIMARY KEY AUTO_INCREMENT,
    nombre_area VARCHAR(60) NOT NULL
);

-- Tabla de Empleados
CREATE TABLE empleado (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre_empleado VARCHAR(60) NOT NULL,
    apellido_empleado VARCHAR(60) NOT NULL,
    edad INT,
	fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    genero VARCHAR(15),
    dui VARCHAR(15),
    salario VARCHAR(15),
    area_id INT NOT NULL,
    FOREIGN KEY (area_id) REFERENCES area(id_area)
);

-- Detalles de la contratacion de los empleados
CREATE TABLE contratacion(
	id_contratacion INT AUTO_INCREMENT PRIMARY KEY,
	empleado_id INT NOT NULL,
	fecha_contratacion DATE,
	estado_contratacion TEXT,
	FOREIGN KEY (empleado_id) REFERENCES empleado(id_empleado)
);

-- Tabla de Vehículos (Ambulancias o vehículos de emergencia)
CREATE TABLE vehiculo (
    id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    marca VARCHAR(60) NOT NULL,
    modelo VARCHAR(60) NOT NULL,
    año INT NOT NULL,
    estado_vehiculo varchar(30),
    empleado_id INT,
    FOREIGN KEY (empleado_id) REFERENCES empleado(id_empleado)
);

-- Tabla de Categorías de Medicamentos
CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(50) NOT NULL,
    nombre_medicamento VARCHAR(50) NOT NULL
);

-- Tabla de Medicamentos
CREATE TABLE medicamento (
    id_medicamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre_medicamento VARCHAR(500) NOT NULL, -- hacer un alter table 
    descripcion TEXT,
    precio DECIMAL(8, 2) NOT NULL,
    existencia INT NOT NULL,
    categoria_id INT,
    fecha_caducida DATE NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id_categoria)
);

-- Tabla de Especialidades Médicas
CREATE TABLE especialidad (
    id_especialidad INT PRIMARY KEY AUTO_INCREMENT,
    nombre_especialidad VARCHAR(60) NOT NULL
);

-- Tabla de Doctores (empleados con rol de médicos)
CREATE TABLE doctor (
    id_doctor INT PRIMARY KEY AUTO_INCREMENT,
	nombre_doctor VARCHAR(60),
    disponibilidad VARCHAR(20),
    especialidad_id INT NOT NULL, 
    telefono VARCHAR(15),
    edad INT,
    FOREIGN KEY (especialidad_id) REFERENCES especialidad(id_especialidad)
);

-- Tabla de Pacientes (modificada para relacionarse con doctores)
CREATE TABLE `paciente` (
    `id_paciente` INT PRIMARY KEY AUTO_INCREMENT,
    `nombre_paciente` VARCHAR(60) NOT NULL,
    `apellido_paciente` VARCHAR(60) NOT NULL,
    `fecha_nacimiento` DATE NOT NULL,
    `direccion` VARCHAR(100),
    `telefono` VARCHAR(15),
    `edad` INT,
    `genero` VARCHAR(15),
    `email` VARCHAR(100),
    `doctor_id` INT,
    `estado_paciente` TEXT,
    FOREIGN KEY (`doctor_id`) REFERENCES doctor(id_doctor)
);

-- Tabla de Recetas Médicas (que vincula pacientes y doctores)
CREATE TABLE receta (
    id_receta INT PRIMARY KEY AUTO_INCREMENT,
    paciente_id INT NOT NULL,
    fecha_receta DATE NOT NULL,
    estado_receta VARCHAR(20) NOT NULL,  
    FOREIGN KEY (paciente_id) REFERENCES paciente(id_paciente)
);

-- Detalle de Medicamentos Recetados (Medicamentos asignados a la receta)
CREATE TABLE detalle_receta (
    id_detallereceta INT PRIMARY KEY AUTO_INCREMENT,
    receta_id INT NOT NULL,
    medicamento_id INT NOT NULL,
    cantidad INT NOT NULL,
    instrucciones TEXT,
    FOREIGN KEY (receta_id) REFERENCES receta(id_receta),
    FOREIGN KEY (medicamento_id) REFERENCES medicamento(id_medicamento)
);

-- Tabla de Proveedores (para reabastecer los medicamentos)
CREATE TABLE proveedor (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre_proveedor VARCHAR(180) NOT NULL,
    contacto VARCHAR(60),
    telefono VARCHAR(15),
    direccion VARCHAR(100)
);

-- Tabla de Pedidos de Medicamentos (para reabastecer la farmacia)
CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    proveedor_id INT,
    fecha DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_entrega_estimada date,
    Método_de_envío TEXT,
    FOREIGN KEY (proveedor_id) REFERENCES proveedor(id_proveedor)
);

-- Detalles de los Pedidos de Medicamentos
CREATE TABLE detallesPedido (
    id_detallesPedido INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    medicamento_id INT,
    cantidad INT NOT NULL,
    precio DECIMAL(8, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id_pedido),
    FOREIGN KEY (medicamento_id) REFERENCES medicamento(id_medicamento)
);

-- Tabla de Citas
CREATE TABLE cita (
    id_cita INT PRIMARY KEY AUTO_INCREMENT,
    paciente_id INT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado VARCHAR(200) NOT NULL,
    motivo VARCHAR(200) NOT NULL,
    sala VARCHAR(200) NOT NULL,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id_paciente)
);

-- Tabla de Traslados de Pacientes (ambulancias)
CREATE TABLE traslado (
    id_traslado INT PRIMARY KEY AUTO_INCREMENT,
    paciente_id INT,
    vehiculo_id INT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,	
    destino VARCHAR(100) NOT NULL,
    tipo_de_traslado VARCHAR(100) NOT NULL,
    Motivo_del_traslado VARCHAR(100),
    FOREIGN KEY (paciente_id) REFERENCES paciente(id_paciente),
    FOREIGN KEY (vehiculo_id) REFERENCES vehiculo(id_vehiculo)   
);