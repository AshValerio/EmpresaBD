-- Crear la base de datos
CREATE DATABASE EmpresaBD;
USE EmpresaBD;

-- Crear la tabla Territorio
CREATE TABLE Territorio (
    CodigoTerritorial INT NOT NULL PRIMARY KEY,
    Distrito NVARCHAR(50) NOT NULL,
    Canton NVARCHAR(50) NOT NULL,
    Provincia NVARCHAR(50) NOT NULL
);

-- Crear la tabla Proveedor
CREATE TABLE Proveedor (
    CodigoProveedor INT PRIMARY KEY,
    Cedula INT NOT NULL,
	TipoCedula NVARCHAR(100) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    CorreoElectronico NVARCHAR(100),
    Telefono INT,
	CodigoTerritorial INT NOT NULL,
CONSTRAINT FKIDTerr FOREIGN KEY (CodigoTerritorial) REFERENCES Territorio(CodigoTerritorial)
);

-- Crear la tabla Categoría
CREATE TABLE Categoria (
    CodigoCat INT PRIMARY KEY,
    NombreCat NVARCHAR(100)
);

-- Crear la tabla Subcategoría
CREATE TABLE Subcategoria (
    Codigosub INT PRIMARY KEY,
    NombreSub NVARCHAR(100),
	CodigoCat int,
CONSTRAINT FKIDCat FOREIGN KEY (CodigoCat) REFERENCES Categoria(CodigoCat)
);
	
-- Crear la tabla Producto
CREATE TABLE Producto (
	Consecutivo INT PRIMARY KEY,
    CodigoProducto INT NOT NULL,
    NombreProducto NVARCHAR(100) NOT NULL,
    Precio INT NOT NULL,
    Tamano NVARCHAR(50),
    Color NVARCHAR(50),
	Descripcion NVARCHAR(100) NOT NULL,
	Marca NVARCHAR(50),
	CodigoProveedor INT,
	CodigoSub INT,
CONSTRAINT FKIDProv FOREIGN KEY (CodigoProveedor) REFERENCES Proveedor(CodigoProveedor),
CONSTRAINT FKIDSub FOREIGN KEY (CodigoSub) REFERENCES Subcategoria(CodigoSub)
);


-- Crear la tabla Cliente
CREATE TABLE Cliente (
    CedulaCliente INT PRIMARY KEY,
	TipoCedula NVARCHAR(100) NOT NULL,
    NombreCliente NVARCHAR(100) NOT NULL,
    Direccion NVARCHAR(200),
    CorreoECliente NVARCHAR(100)
);

-- Crear la tabla Factura
CREATE TABLE Factura (
    NumeroFactura INT PRIMARY KEY,
    ProductoAdq NVARCHAR(100) NOT NULL,
    UnidadesAdq INT NOT NULL,
    Precio INT NOT NULL,
    PorcImpuestos DECIMAL(5, 2) NOT NULL,
    PorcDescuento DECIMAL(5, 2),
	Fecha DATE,
	CedulaCliente INT,
CONSTRAINT FKIDCed FOREIGN KEY (CedulaCliente) REFERENCES Cliente(CedulaCliente)
);

--Creat la tabla Factura-Producto
CREATE TABLE FactProd (
    CodigoFactProd INT IDENTITY (1,1) PRIMARY KEY,
	Cantidad INT CHECK (cantidad >0),
	NumeroFactura int NOT NULL,
    Consecutivo int NOT NULL,
CONSTRAINT FKIDNumF FOREIGN KEY (NumeroFactura) REFERENCES Factura(NumeroFactura),
CONSTRAINT FKIDCon FOREIGN KEY (Consecutivo) REFERENCES Producto(Consecutivo)
); 

-- Llenar las tablas con datos de prueba

USE EmpresaBD;

-- Insertar territorios
INSERT INTO Territorio(CodigoTerritorial, Distrito, Canton, Provincia)
VALUES (10101,'San Jose', 'San Jose', 'San Jose'),
(40103, 'San Francisco', 'Heredia', 'Heredia'),
(60702, 'Puntarenas', 'Golfito', 'Puerto Jiménez'),
(30202, 'Cartago', 'Paraiso', 'Cervantes'),
(11502, 'San Jose', 'Montes de Oca', 'San Rafael');

-- Insertar proveedores
INSERT INTO Proveedor(CodigoProveedor, Cedula, TipoCedula, Nombre, CorreoElectronico, Telefono, CodigoTerritorial)
VALUES (810, 00030405060, 'Jurídica', 'PortaretratosArte S.A.', 'info@portaretratosarte.com', 85555866,40103),
(321, 00405785676,  'JurÍdica','CamisasConejo', 'camisasconejos@gmail.com', 22874598, 30202),
(852, 112334455, 'Física', 'CumpleañosEspectaculares', 'ventas@cumpleañosespectaculares.com', 22556666, 11502),
(258, 112234318, 'Física', 'AniversarioElegante', 'ventas@aniversarioelegante.com', 89799000, 60702),
(987, 0040238576, 'Jurídica', 'Arte Impresionado', 'arte.impresionado@gmail.com', 22818364, 10101);

-- Insertar categorías
INSERT INTO Categoria(NombreCat, CodigoCat)
VALUES ('Textil',1),
('Decoración', 2),
('Regalos', 3);

-- Insertar subcategorías
INSERT INTO Subcategoria(CodigoCat, NombreSub, Codigosub)
VALUES (1, 'Camisetas', 101),
(1,'Uniformes', 102),
(2, 'Portaretratos', 201),
(2, 'Lienzos', 202),
(3, 'Cumpleaños', 301),
(3, 'Aniversario',302);

-- Insertar productos
INSERT INTO Producto  (Consecutivo, NombreProducto, Precio, Tamano, Color, Descripcion, Marca, CodigoProveedor,CodigoSub, CodigoProducto) 
VALUES(1001, 'Camiseta Personalizada', 5000, 'M', 'Blanco', 'Camiseta de algodón con diseño personalizado', 'CamisetaConejo', 321, 101,667),
(3001, 'Portaretratos de Madera', 2500, '8x10', 'Marrón', 'Portaretratos de madera con diseño clásico', 'PortaretratosArte', 987, 201,1810),
(4002, 'Lienzo Abstracto', 3000, '20x24', 'Multicolor', 'Lienzo con diseño abstracto personalizado', 'LienzosPersonalizados', 987, 202,668),
(6001, 'Regalos de Aniversario', 10000, 'Varía', 'Varios', 'Regalos personalizados para aniversarios', 'AniversarioEleg.', 258, 302, 767),
(5001, 'Kit de Cumpleaños', 8000, 'Varía', 'Varios', 'Kit completo para fiestas de cumpleaños', 'Cumpleaños', 852, 301, 810);

--Insertar clientes
INSERT INTO Cliente(CedulaCliente,TipoCedula,NombreCliente,Direccion,CorreoECliente)
VALUES (108446798, 'Fisica', 'Daniel Solis', '75m Este de la Municipalidad Montes de Oca', 'dani.solis@gmail.com'),
(112334455, 'Física', 'Juan Pérez', '123 Calle Principal, Ciudad', 'juanperez@email.com'),
(00405060780, 'Jurídica', 'Empresa ABC S.A.', '456 Avenida Central, Ciudad', 'info@empresaabc.com'),
(00060708090, 'Jurídica', 'Distribuidora 123 S.A.', '1010 Avenida Norte, Ciudad', 'ventas@distribuidora123.com'),
(00790905436, 'Jurídica', 'Tienda de Regalos Felices S.A.', '222 Plaza Mayor, Ciudad', 'info@tiendaderegalosfelices.com');

-- Insertar facturas
INSERT INTO Factura(ProductoAdq, UnidadesAdq, Precio, PorcImpuestos, PorcDescuento, Fecha, CedulaCliente, NumeroFactura)
VALUES ('Camiseta Personalizada', 3, 5000, 13, 5, '2023-09-01', 112334455,5100),
('Portaretrato de Madera', 2, 2500, 10, 0, '2023-09-02', 00060708090, 5101),
('Lienzo con Abstracto', 1, 3000, 15, 2, '2023-09-03', 00405060780,5102),
('Kit de Cumpleaños', 5, 8000, 10, 8, '2023-09-04', 00790905436,5103),
('Regalos de Aniversario', 2, 10000, 12, 3, '2023-09-05', 108446798,5104);

--Insertar Facturas-Prducto

INSERT INTO FactProd(Cantidad,NumeroFactura,Consecutivo)
VALUES (3, 5100, 1001),
(2, 5101, 3001),
(1,5102, 4002),
(5, 5103, 5001),
(2, 5104, 6001);