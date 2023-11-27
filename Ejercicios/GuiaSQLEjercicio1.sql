-- 1. Obtener los datos completos de los empleados.
SELECT * FROM EMPLEADOS;
-- 2. Obtener los datos completos de los departamentos.
SELECT * FROM DEPARTAMENTOS;
-- 3. Listar el nombre de los departamentos.
SELECT NOMBRE_DEPTO from DEPARTAMENTOS;
-- 4. Obtener el nombre y salario de todos los empleados.
SELECT NOMBRE, SAL_EMP FROM EMPLEADOS;
-- 5. Listar todas las comisiones
SELECT COMISION_EMP FROM EMPLEADOS;
-- 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT * FROM EMPLEADOS WHERE CARGO_EMP = 'SECRETARIA';
-- 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT * FROM EMPLEADOS WHERE CARGO_EMP = 'VENDEDOR' order by NOMBRE;
-- 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT NOMBRE, CARGO_EMP  FROM EMPLEADOS order by SAL_EMP;
-- 9. Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad de “Ciudad Real”
SELECT NOMBRE_JEFE_DEPTO FROM DEPARTAMENTOS WHERE CIUDAD = 'CIUDAD REAL';
-- 10. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
SELECT NOMBRE AS NOMBRE , CARGO_EMP AS CARGO FROM EMPLEADOS;
-- 11. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT SAL_EMP, COMISION_EMP FROM EMPLEADOS WHERE ID_DEPTO = 2000 ORDER BY COMISION_EMP; 
-- 12. Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta de: sumar el salario y la comisión, 
-- más una bonificación de 500. Mostrar el nombre del empleado y el total a pagar, en orden alfabético.
SELECT NOMBRE, (SAL_EMP+COMISION_EMP+500) AS TOTAL_A_PAGAR FROM EMPLEADOS WHERE ID_DEPTO = 3000 ORDER BY NOMBRE;
-- 13. Muestra los empleados cuyo nombre empiece con la letra J.
SELECT * FROM EMPLEADOS WHERE NOMBRE LIKE 'J%';
-- 14. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que tienen comisión superior a 1000.
SELECT SAL_EMP, COMISION_EMP, (SAL_EMP+COMISION_EMP) AS SALARIO_TOTAL, NOMBRE FROM EMPLEADOS WHERE COMISION_EMP > 1000;
-- 15. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT SAL_EMP, COMISION_EMP, (SAL_EMP+COMISION_EMP) AS SALARIO_TOTAL, NOMBRE FROM EMPLEADOS WHERE COMISION_EMP =0 ;
-- 16. Obtener la lista de los empleados que ganan una comisión superior a su sueldo
SELECT * FROM EMPLEADOS WHERE COMISION_EMP > SAL_EMP;
-- 17. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT *, (SAL_EMP*0.30) AS TREINTA_PORCIENTO_SALARIO FROM EMPLEADOS WHERE COMISION_EMP <= (SAL_EMP*0.3);
-- 18. Hallar los empleados cuyo nombre no contiene la cadena “MA”
SELECT * FROM EMPLEADOS WHERE NOMBRE NOT LIKE '%MA%';
-- 19. Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o ‘Mantenimiento.
SELECT * FROM DEPARTAMENTOS WHERE NOMBRE_DEPTO='VENTAS' OR NOMBRE_DEPTO='INVESTIGACION' OR NOMBRE_DEPTO='MANTENIMIENTO';
-- 20. Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento.
SELECT * FROM DEPARTAMENTOS WHERE NOMBRE_DEPTO <> 'VENTAS' AND NOMBRE_DEPTO <>'INVESTIGACION' AND NOMBRE_DEPTO <> 'MANTENIMIENTO';
-- 21. Mostrar el salario más alto de la empresa.
SELECT MAX(SAL_EMP) AS SALARIO_MAXIMO FROM EMPLEADOS; 
-- 22. Mostrar el nombre del último empleado de la lista por orden alfabético
SELECT MAX(NOMBRE) FROM EMPLEADOS;
-- 23. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT MAX(SAL_EMP) AS SALARIO_MAXIMO, MIN(SAL_EMP) AS SALARIO_MINIMO, MAX(SAL_EMP)-MIN(SAL_EMP) AS DIFERENCIA FROM EMPLEADOS;
-- 24. Hallar el salario promedio por departamento.
	-- POR ID_DEPTO
SELECT ID_DEPTO, AVG(SAL_EMP) AS PROMEDIO_SALARIO FROM EMPLEADOS group by ID_DEPTO;
	-- POR ID_DEPTO Y NOMBRE DE DEPARTAMENTO
SELECT e.id_depto, d.nombre_depto, AVG(e.sal_emp) AS salario_promedio FROM departamentos d INNER JOIN empleados e ON d.id_depto = e.id_depto GROUP BY d.id_depto; -- Trabajando sobre las 2 tablas.

-- *** CONSULTAS CON HAVING ***
-- 25. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
	-- POR ID_DEPTO
SELECT ID_DEPTO, COUNT(NOMBRE) AS CANTIDAD_EMPLEADOS FROM EMPLEADOS GROUP BY ID_DEPTO HAVING COUNT(ID_DEPTO)>3;
	-- POR NOMBRE DE DEPARTAMENTO
select e.id_depto, d.nombre_depto as 'Departamento', count(e.nombre) as 'Cant. de empleados' from departamentos d 
inner join empleados e on d.id_depto=e.id_depto group by d.nombre_depto having count(e.nombre)>3;
-- 26. Hallar los departamentos que no tienen empleados
-- POR ID_DEPTO
SELECT ID_DEPTO, COUNT(NOMBRE) AS CANTIDAD_EMPLEADOS FROM EMPLEADOS GROUP BY ID_DEPTO HAVING COUNT(ID_DEPTO)=0;
	-- POR NOMBRE DE DEPARTAMENTO
select e.id_depto, d.nombre_depto as 'Departamento', count(e.nombre) as 'Cant. de empleados' from departamentos d 
inner join empleados e on d.id_depto=e.id_depto group by d.nombre_depto having count(e.nombre)=0;

-- *** CONSULTA CON SUBCONSULTA 
-- 28. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento
SELECT * FROM EMPLEADOS WHERE SAL_EMP >= (SELECT AVG(SAL_EMP) FROM EMPLEADOS) ORDER BY ID_DEPTO;

