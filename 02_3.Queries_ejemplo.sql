-- 1. Mostrar los estudiantes de un bootcamp específico (ej. Java Fullstack)
SELECT name, surname, mail 
FROM students 
WHERE id_bootcamp = (SELECT id_bootcamp FROM bootcamps WHERE name = 'Java Fullstack');

-- 2. Obtener información de un estudiante específico (ej. Pedro Sánchez)
SELECT * 
FROM students 
WHERE name = 'Pedro' AND surname = 'Sánchez';

-- 3. Mostrar el correo electrónico de un profesor con nombre específico (ej. Claudia Jiménez)
SELECT mail 
FROM teachers 
WHERE name = 'Claudia' AND surname = 'Jiménez';

-- 4. Listar todas las asignaturas impartidas en un bootcamp (ej. Desarrollo Web Fullstack)
SELECT name 
FROM subjects 
WHERE id_bootcamp = (SELECT id_bootcamp FROM bootcamps WHERE name = 'Desarrollo Web Fullstack');

-- 5. Mostrar las asignaturas que imparte un profesor específico (ej. Javier Torres)
SELECT s.name AS subject_name 
FROM subjects s
JOIN teacher_subject ts ON s.id_subject = ts.id_subject
JOIN teachers t ON ts.id_teacher = t.id_teacher
WHERE t.name = 'Javier' AND t.surname = 'Torres';

-- 6. Listar los profesores que imparten asignaturas en el bootcamp "Big Data, IA & Machine Learning"
SELECT DISTINCT t.name, t.surname
FROM teachers t
JOIN teacher_subject ts ON t.id_teacher = ts.id_teacher
JOIN subjects s ON ts.id_subject = s.id_subject
WHERE s.id_bootcamp = (SELECT id_bootcamp FROM bootcamps WHERE name = 'Big Data, IA & Machine Learning');

-- 7. Contar el número de estudiantes en cada bootcamp
SELECT b.name AS bootcamp_name, COUNT(s.id_student) AS num_students
FROM students s
JOIN bootcamps b ON s.id_bootcamp = b.id_bootcamp
GROUP BY b.name;

-- 8. Mostrar los detalles de un estudiante por su correo electrónico (ej. maria.garcia@example.com)
SELECT * 
FROM students 
WHERE mail = 'maria.garcia@example.com';

-- 9. Listar los bootcamps que tienen más de 2 estudiantes inscritos
SELECT b.name AS bootcamp_name, COUNT(s.id_student) AS num_students
FROM students s
JOIN bootcamps b ON s.id_bootcamp = b.id_bootcamp
GROUP BY b.name
HAVING COUNT(s.id_student) > 2;

-- 10. Obtener los detalles del bootcamp y los profesores para una asignatura específica (ej. 'Blockchain Avanzado')
SELECT b.name AS bootcamp_name, t.name AS teacher_name, t.surname AS teacher_surname
FROM subjects s
JOIN bootcamps b ON s.id_bootcamp = b.id_bootcamp
JOIN teacher_subject ts ON s.id_subject = ts.id_subject
JOIN teachers t ON ts.id_teacher = t.id_teacher
WHERE s.name = 'Blockchain Avanzado';
