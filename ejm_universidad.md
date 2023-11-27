```sql
CREATE DATABASE universidad;
USE universidad;

```
```sql
CREATE TABLE carrera (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    duracion INT NOT NULL,  -- en años
    descripcion TEXT
);

```
```sql
CREATE TABLE estudiante (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    carrera_id INT,
    FOREIGN KEY (carrera_id) REFERENCES carrera(id)
);

```
```sql
CREATE TABLE profesor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(100)
);

```
```sql
CREATE TABLE curso (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    carrera_id INT,
    profesor_id INT,
    FOREIGN KEY (carrera_id) REFERENCES carrera(id),
    FOREIGN KEY (profesor_id) REFERENCES profesor(id)
);

```
```sql
CREATE TABLE inscripcion (
    estudiante_id INT,
    curso_id INT,
    PRIMARY KEY (estudiante_id, curso_id),
    FOREIGN KEY (estudiante_id) REFERENCES estudiante(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);

```
##Consultas

```sql
-- Selecciona el nombre del curso y la cantidad de estudiantes inscritos en cada curso
SELECT c.nombre AS curso, COUNT(i.estudiante_id) AS cantidad_estudiantes
FROM curso c
LEFT JOIN inscripcion i ON c.id = i.curso_id
GROUP BY c.nombre;

```
```sql
-- Selecciona estudiantes que han nacido después del año 2000
SELECT * FROM estudiante WHERE YEAR(fecha_nacimiento) > 2000;

```
```sql

```
```sql
-- Muestra el nombre de la carrera y la cantidad de cursos asociados a cada una
SELECT ca.nombre AS carrera, COUNT(c.id) AS cantidad_cursos
FROM carrera ca
LEFT JOIN curso c ON ca.id = c.carrera_id
GROUP BY ca.nombre;

```
```sql
-- Selecciona estudiantes que están inscritos en al menos un curso
SELECT e.nombre AS estudiante
FROM estudiante e
WHERE EXISTS (SELECT 1 FROM inscripcion i WHERE e.id = i.estudiante_id);

```
```sql
-- Muestra el nombre del curso y los nombres de los estudiantes inscritos en cada curso
SELECT c.nombre AS curso, e.nombre AS estudiante
FROM curso c
LEFT JOIN inscripcion i ON c.id = i.curso_id
LEFT JOIN estudiante e ON i.estudiante_id = e.id;

```

```sql
-- Muestra el nombre de los profesores que imparten cursos en más de una carrera
SELECT DISTINCT p.nombre AS profesor
FROM profesor p
JOIN curso c ON p.id = c.profesor_id
JOIN carrera ca ON c.carrera_id = ca.id
GROUP BY p.id
HAVING COUNT(DISTINCT ca.id) > 1;

```

```sql
-- Selecciona cursos con al menos dos estudiantes inscritos
SELECT c.nombre AS curso, COUNT(i.estudiante_id) AS cantidad_estudiantes
FROM curso c
JOIN inscripcion i ON c.id = i.curso_id
GROUP BY c.nombre
HAVING COUNT(i.estudiante_id) >= 2;

```
```sql
-- Muestra el nombre de cada estudiante y la cantidad de cursos en los que están inscritos
SELECT e.nombre AS estudiante, COUNT(i.curso_id) AS cantidad_cursos
FROM estudiante e
LEFT JOIN inscripcion i ON e.id = i.estudiante_id
GROUP BY e.nombre;

```
```sql
-- Selecciona estudiantes que están inscritos en todos los cursos
SELECT e.nombre AS estudiante
FROM estudiante e
WHERE NOT EXISTS (
    SELECT c.id
    FROM curso c
    WHERE NOT EXISTS (
        SELECT i.curso_id
        FROM inscripcion i
        WHERE i.estudiante_id = e.id AND i.curso_id = c.id
    )
);

```

```sql
-- Muestra los cinco estudiantes más jóvenes ordenados por fecha de nacimiento
SELECT *
FROM estudiante
ORDER BY fecha_nacimiento DESC
LIMIT 5;

```
```sql
-- Selecciona la carrera con la mayor duración
SELECT * FROM carrera
WHERE duracion = (SELECT MAX(duracion) FROM carrera);

-- Selecciona la carrera con la menor duración
SELECT * FROM carrera
WHERE duracion = (SELECT MIN(duracion) FROM carrera);

```
```sql
-- Muestra el nombre del curso y los nombres de los estudiantes inscritos en cada curso (incluyendo cursos sin estudiantes)
SELECT c.nombre AS curso, COALESCE(e.nombre, 'Ninguno') AS estudiante
FROM curso c
LEFT JOIN inscripcion i ON c.id = i.curso_id
LEFT JOIN estudiante e ON i.estudiante_id = e.id;

```
```sql
-- Selecciona estudiantes que están inscritos en cursos de todas las carreras
SELECT e.nombre AS estudiante
FROM estudiante e
WHERE (SELECT COUNT(DISTINCT c.carrera_id) FROM curso c) = (
    SELECT COUNT(DISTINCT ca.id)
    FROM carrera ca
    LEFT JOIN curso c ON ca.id = c.carrera_id
    LEFT JOIN inscripcion i ON c.id = i.curso_id
    WHERE i.estudiante_id = e.id
);

```

```sql
-- Muestra cursos cuyo nombre tiene exactamente cinco caracteres
SELECT * FROM curso WHERE LENGTH(nombre) = 5;

```
```sql
-- Muestra estudiantes cuyo apellido termina con "ez"
SELECT * FROM estudiante WHERE apellido LIKE '%ez';

```
```SQL
-- Muestra cursos cuyo nombre contiene la palabra "Programación"
SELECT * FROM curso WHERE nombre LIKE '%Programación%';

```
```SQL
-- Muestra el nombre del estudiante y el nombre del curso en el que están inscritos
SELECT e.nombre AS estudiante, c.nombre AS curso
FROM estudiante e
INNER JOIN inscripcion i ON e.id = i.estudiante_id
INNER JOIN curso c ON i.curso_id = c.id;

```
```SQL 
-- Muestra el nombre del curso y el nombre del profesor solo si hay un profesor asignado
SELECT c.nombre AS curso, p.nombre AS profesor
FROM curso c
LEFT JOIN profesor p ON c.profesor_id = p.id
INNER JOIN carrera ca ON c.carrera_id = ca.id;
```