# README - Guía de MySQL (Resumen Completo)

## 1. Crear y usar bases de datos

``` sql
CREATE DATABASE prueba;
SHOW DATABASES;
USE prueba;
DROP DATABASE prueba;
```

## 2. Tipos de datos

-   INT, TINYINT, SMALLINT, BIGINT
-   DECIMAL(p,s)
-   FLOAT, DOUBLE
-   CHAR, VARCHAR
-   TEXT
-   DATE, TIME, DATETIME, TIMESTAMP
-   BOOLEAN

## 3. Crear tablas

``` sql
CREATE TABLE categorias(
 id TINYINT AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL UNIQUE
);
```

### Restricciones

-   PRIMARY KEY
-   FOREIGN KEY
-   NOT NULL
-   UNIQUE
-   DEFAULT
-   CHECK
-   AUTO_INCREMENT

## 4. Relaciones

### 1:1

``` text
persona(id) ---- pasaporte(id_persona)
```

### 1:N

``` text
categorias(id)
      |
      +----< subcategorias(id_categoria)
```

### N:M

``` text
estudiantes >--- matriculas ---< cursos
```

## 5. ALTER TABLE

``` sql
ALTER TABLE productos ADD precio DECIMAL(10,2);
ALTER TABLE productos MODIFY precio DECIMAL(12,2);
ALTER TABLE productos DROP COLUMN precio;
```

## 6. INSERT

``` sql
INSERT INTO categorias(nombre) VALUES('Alimentos');
INSERT INTO categorias(nombre)
VALUES ('A'),('B'),('C');
```

## 7. UPDATE

``` sql
UPDATE categorias
SET nombre='Bebidas'
WHERE id=1;
```

## 8. DELETE

``` sql
DELETE FROM categorias WHERE id=1;
TRUNCATE TABLE categorias;
```

## 9. SELECT

``` sql
SELECT * FROM productos;
SELECT nombre,descripcion FROM productos;
SELECT DISTINCT nombre FROM categorias;
```

## 10. WHERE

``` sql
WHERE precio>100
WHERE precio>=100
WHERE precio<>100
WHERE nombre='Juan'
WHERE nombre LIKE 'A%'
WHERE nombre LIKE '%cola%'
WHERE id IN(1,2,3)
WHERE precio BETWEEN 100 AND 500
WHERE email IS NULL
WHERE email IS NOT NULL
```

## 11. ORDER BY / LIMIT

``` sql
ORDER BY nombre ASC;
ORDER BY nombre DESC;
LIMIT 10;
LIMIT 10 OFFSET 20;
```

## 12. Funciones

``` sql
COUNT(*)
SUM(valor)
AVG(valor)
MIN(valor)
MAX(valor)
CONCAT(nombre,' ',apellido)
UPPER(nombre)
LOWER(nombre)
NOW()
CURDATE()
YEAR(fecha)
```

## 13. GROUP BY

``` sql
SELECT id_categoria,COUNT(*)
FROM subcategorias
GROUP BY id_categoria;

SELECT id_categoria,COUNT(*)
FROM subcategorias
GROUP BY id_categoria
HAVING COUNT(*)>1;
```

## 14. JOIN

### INNER JOIN

``` sql
SELECT p.nombre,s.nombre
FROM productos p
INNER JOIN subcategorias s
ON p.id_subcategoria=s.id;
```

### LEFT JOIN

``` sql
SELECT c.nombre,s.nombre
FROM categorias c
LEFT JOIN subcategorias s
ON c.id=s.id_categoria;
```

### RIGHT JOIN

``` sql
SELECT *
FROM categorias c
RIGHT JOIN subcategorias s
ON c.id=s.id_categoria;
```

### CROSS JOIN

``` sql
SELECT *
FROM categorias
CROSS JOIN unidades_de_medida;
```

## 15. Subconsultas

``` sql
SELECT *
FROM productos
WHERE id_subcategoria=
(
SELECT id
FROM subcategorias
WHERE nombre='Lácteos'
);
```

## 16. Vistas

``` sql
CREATE VIEW vw_productos AS
SELECT p.nombre,s.nombre subcategoria
FROM productos p
JOIN subcategorias s
ON p.id_subcategoria=s.id;
```

## 17. Índices

``` sql
CREATE INDEX idx_nombre
ON productos(nombre);
```

## 18. Transacciones

``` sql
START TRANSACTION;
UPDATE productos SET nombre='X' WHERE id=1;
COMMIT;
ROLLBACK;
```

## 19. Usuarios

``` sql
CREATE USER 'admin'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
FLUSH PRIVILEGES;
```

## 20. Consultas de práctica

``` sql
SELECT * FROM productos;
SELECT * FROM productos ORDER BY nombre;
SELECT * FROM compras WHERE valor_total>200000;
SELECT * FROM proveedores WHERE email IS NULL;
SELECT p.nombre,s.nombre
FROM productos p
JOIN subcategorias s ON p.id_subcategoria=s.id;
SELECT p.nombre,c.nombre
FROM productos p
JOIN subcategorias s ON p.id_subcategoria=s.id
JOIN categorias c ON s.id_categoria=c.id;
SELECT pr.nombre,ci.nombre
FROM proveedores pr
JOIN ciudades ci ON pr.id_ciudad=ci.id;
SELECT ci.nombre,pa.nombre
FROM ciudades ci
JOIN paises pa ON ci.id_pais=pa.id;
SELECT b.nombre,ci.nombre
FROM bodegas b
JOIN ciudades ci ON b.id_ciudad=ci.id;
SELECT COUNT(*) FROM productos;
SELECT SUM(valor_total) FROM compras;
SELECT AVG(precio_unitario) FROM detalles_compras;
```

## 21. Orden recomendado de estudio

1.  CREATE DATABASE
2.  CREATE TABLE
3.  INSERT
4.  SELECT
5.  WHERE
6.  ORDER BY
7.  Funciones
8.  GROUP BY
9.  JOIN
10. Subconsultas
11. VIEW
12. Índices
13. Procedimientos
14. Triggers
15. Transacciones
