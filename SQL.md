# 📚 Guía Completa de MySQL

![MySQL](https://img.shields.io/badge/MySQL-8.x-blue?style=for-the-badge&logo=mysql)
![SQL](https://img.shields.io/badge/SQL-Learning-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

> Una guía completa para aprender **MySQL desde cero hasta un nivel profesional**, con teoría, ejemplos, diagramas, ejercicios y proyectos.

---

# 📑 Contenido

- [📖 Introducción](#-introducción)
- [🗄️ Bases de Datos](#️-bases-de-datos)
- [📋 Tipos de Datos](#-tipos-de-datos)
- [🏗️ DDL](#️-ddl)
- [🔑 Primary Key](#-primary-key)
- [🔗 Foreign Key](#-foreign-key)
- [📊 Relaciones](#-relaciones)
- [➕ INSERT](#-insert)
- [✏️ UPDATE](#️-update)
- [❌ DELETE](#-delete)
- [🔍 SELECT](#-select)
- [🎯 WHERE](#-where)
- [📈 ORDER BY](#-order-by)
- [📦 GROUP BY](#-group-by)
- [🤝 JOIN](#-join)
- [📚 Subconsultas](#-subconsultas)
- [👁️ Vistas](#️-vistas)
- [⚡ Índices](#-índices)
- [🔄 Procedimientos](#-procedimientos-almacenados)
- [⚙️ Triggers](#️-triggers)
- [💾 Transacciones](#-transacciones)
- [📝 Ejercicios](#-ejercicios)

---

# 📖 Introducción

MySQL es un Sistema Gestor de Bases de Datos Relacional (RDBMS).

Permite almacenar información en tablas relacionadas mediante claves primarias y claves foráneas.

---

# 🗄️ Bases de Datos

## Crear una base de datos

```sql
CREATE DATABASE empresa;
```

## Mostrar las bases de datos

```sql
SHOW DATABASES;
```

## Seleccionar una base de datos

```sql
USE empresa;
```

## Eliminar una base de datos

```sql
DROP DATABASE empresa;
```

---

# 📋 Tipos de Datos

## Numéricos

| Tipo | Descripción |
|------|-------------|
| TINYINT | Enteros pequeños |
| SMALLINT | Enteros |
| INT | Enteros normales |
| BIGINT | Enteros grandes |
| DECIMAL | Valores monetarios |
| FLOAT | Decimales |

---

## Texto

| Tipo | Descripción |
|------|-------------|
| CHAR | Longitud fija |
| VARCHAR | Longitud variable |
| TEXT | Texto largo |

---

## Fecha

| Tipo |
|------|
| DATE |
| TIME |
| DATETIME |
| TIMESTAMP |

---

# 🏗️ DDL

Crear una tabla.

```sql
CREATE TABLE categorias(

    id INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL

);
```

---

# 🔑 Primary Key

Una Primary Key identifica de forma única un registro.

```
+----------------------+
| categorias           |
+----------------------+
| id (PK)              |
| nombre               |
+----------------------+
```

---

# 🔗 Foreign Key

Una Foreign Key conecta dos tablas.

```sql
CREATE TABLE productos(

    id INT AUTO_INCREMENT PRIMARY KEY,

    nombre VARCHAR(100),

    id_categoria INT,

    FOREIGN KEY(id_categoria)

    REFERENCES categorias(id)

);
```

---

## ¿Cómo funciona?

```
categorias

+----+------------+

| 1  | Alimentos  |

| 2  | Bebidas    |

+----+------------+

        ▲

        │

        │

productos

+-----------------------------+

| Leche       id_categoria = 1 |

| Arroz       id_categoria = 1 |

| Coca Cola   id_categoria = 2 |

+-----------------------------+
```

---

# 📊 Relaciones

## Uno a Uno (1:1)

```
Persona

↓

Pasaporte
```

---

## Uno a Muchos (1:N)

```
Categoría

↓

Productos
```

---

## Muchos a Muchos (N:M)

```
Estudiantes

↓

Matrículas

↓

Cursos
```

---

# ➕ INSERT

```sql
INSERT INTO categorias(nombre)

VALUES('Alimentos');
```

Insertar varios registros.

```sql
INSERT INTO categorias(nombre)

VALUES

('Bebidas'),

('Aseo'),

('Tecnología');
```

---

# 🔍 SELECT

```sql
SELECT *

FROM productos;
```

Seleccionar columnas.

```sql
SELECT

nombre,

precio

FROM productos;
```

---

# 🎯 WHERE

```sql
SELECT *

FROM productos

WHERE precio > 100;
```

LIKE

```sql
WHERE nombre LIKE 'A%'
```

BETWEEN

```sql
WHERE precio BETWEEN 1000 AND 5000
```

IN

```sql
WHERE id IN (1,2,3)
```

NULL

```sql
WHERE email IS NULL
```

NOT NULL

```sql
WHERE email IS NOT NULL
```

---

# 📈 ORDER BY

```sql
ORDER BY nombre ASC;
```

```sql
ORDER BY nombre DESC;
```

---

# 📦 GROUP BY

```sql
SELECT

id_categoria,

COUNT(*)

FROM productos

GROUP BY id_categoria;
```

---

# 🤝 JOIN

## INNER JOIN

```sql
SELECT

p.nombre,

c.nombre

FROM productos p

INNER JOIN categorias c

ON p.id_categoria = c.id;
```

---

## LEFT JOIN

```sql
SELECT

c.nombre,

p.nombre

FROM categorias c

LEFT JOIN productos p

ON c.id = p.id_categoria;
```

---

## RIGHT JOIN

```sql
SELECT *

FROM categorias c

RIGHT JOIN productos p

ON c.id = p.id_categoria;
```

---

## CROSS JOIN

```sql
SELECT *

FROM categorias

CROSS JOIN proveedores;
```

---

# 📚 Subconsultas

```sql
SELECT *

FROM productos

WHERE id_categoria = (

SELECT id

FROM categorias

WHERE nombre='Alimentos'

);
```

---

# 👁️ Vistas

```sql
CREATE VIEW vw_productos AS

SELECT *

FROM productos;
```

---

# 💾 Transacciones

```sql
START TRANSACTION;

UPDATE productos

SET precio = 5000

WHERE id=1;

COMMIT;
```

Rollback.

```sql
ROLLBACK;
```

---

# 📝 Ejercicios

- Mostrar todos los productos.
- Mostrar productos con su categoría.
- Mostrar proveedores con su ciudad.
- Mostrar ciudades con su país.
- Mostrar compras con su proveedor.
- Mostrar el total comprado por categoría.
- Mostrar productos sin categoría.
- Mostrar categorías sin productos.
- Mostrar proveedores sin correo.
- Mostrar el promedio de compras.

---

# 📚 Próximos capítulos

- Tipos de Datos
- DDL
- DML
- JOIN
- Funciones
- Procedimientos
- Triggers
- Índices
- Optimización
- Proyecto Final

---

## ⭐ Si este repositorio te ayuda, no olvides darle una estrella.
