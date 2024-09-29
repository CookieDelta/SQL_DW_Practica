INSERT INTO bootcamps (id_bootcamp, name) VALUES
(1, 'Programar desde cero'),
(2, 'Java Fullstack'),
(3, 'Big Data, IA & Machine Learning'),
(4, 'Blockchain Fullstack'),
(5, 'Ciberseguridad Fullstack'),
(6, 'Desarrollo de Apps Móviles'),
(7, 'Desarrollo Web Fullstack'),
(8, 'UX/UI Fullstack');


INSERT INTO subjects (id_subject, name, id_bootcamp) VALUES
(1, 'Introducción a la Programación', 1),
(2, 'Estructuras de Datos', 1),
(3, 'Java Basics', 2),
(4, 'Spring Framework', 2),
(5, 'Machine Learning Basics', 3),
(6, 'Data Visualization', 3),
(7, 'Blockchain Fundamentals', 4),
(8, 'Smart Contracts', 4),
(9, 'Ciberseguridad Básica', 5),
(10, 'Análisis de Vulnerabilidades', 5),
(11, 'Desarrollo de Apps Android', 6),
(12, 'Desarrollo de Apps iOS', 6),
(13, 'HTML y CSS', 7),
(14, 'JavaScript y Frameworks', 7),
(15, 'Diseño UX/UI', 8),
(16, 'Prototipado y Herramientas de Diseño', 8);


INSERT INTO teachers (id_teacher, name, surname, mail, phone) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', '1234567890'),
(2, 'María', 'Gómez', 'maria.gomez@example.com', '2345678901'),
(3, 'Carlos', 'López', 'carlos.lopez@example.com', '3456789012'),
(4, 'Ana', 'Martínez', 'ana.martinez@example.com', '4567890123'),
(5, 'Luis', 'Hernández', 'luis.hernandez@example.com', '5678901234');


INSERT INTO teacher_subject (id_subject, id_teacher) VALUES
(1, 1),  -- Introducción a la Programación by Juan Pérez
(2, 1),  -- Estructuras de Datos by Juan Pérez
(3, 2),  -- Java Basics by María Gómez
(4, 2),  -- Spring Framework by María Gómez
(5, 3),  -- Machine Learning Basics by Carlos López
(6, 3),  -- Data Visualization by Carlos López
(7, 4),  -- Blockchain Fundamentals by Ana Martínez
(8, 4),  -- Smart Contracts by Ana Martínez
(9, 5),  -- Ciberseguridad Básica by Luis Hernández
(10, 5), -- Análisis de Vulnerabilidades by Luis Hernández
(11, 1), -- Desarrollo de Apps Android by Juan Pérez
(12, 1), -- Desarrollo de Apps iOS by Juan Pérez
(13, 2), -- HTML y CSS by María Gómez
(14, 2), -- JavaScript y Frameworks by María Gómez
(15, 4), -- Diseño UX/UI by Ana Martínez
(16, 4); -- Prototipado y Herramientas de Diseño by Ana Martínez


INSERT INTO students (id_student, name, surname, mail, phone, id_bootcamp) VALUES
(1, 'Pedro', 'Sánchez', 'pedro.sanchez@example.com', '6789012345', 1),
(2, 'Laura', 'Ramírez', 'laura.ramirez@example.com', '7890123456', 1),
(3, 'Diego', 'Fernández', 'diego.fernandez@example.com', '8901234567', 1),
(4, 'María', 'García', 'maria.garcia@example.com', '9012345678', 2),
(5, 'Fernando', 'Martínez', 'fernando.martinez@example.com', '0123456789', 2),
(6, 'Sofía', 'López', 'sofia.lopez@example.com', '1234567890', 2),
(7, 'Andrés', 'Castillo', 'andres.castillo@example.com', '2345678901', 3),
(8, 'Isabel', 'Moreno', 'isabel.moreno@example.com', '3456789012', 3),
(9, 'Ricardo', 'Rojas', 'ricardo.rojas@example.com', '4567890123', 3),
(10, 'Javier', 'Torres', 'javier.torres@example.com', '5678901234', 4),
(11, 'Vanessa', 'Pérez', 'vanessa.perez@example.com', '6789012345', 4),
(12, 'Carmen', 'Hernández', 'carmen.hernandez@example.com', '7890123456', 4),
(13, 'Claudia', 'Jiménez', 'claudia.jimenez@example.com', '8901234567', 5),
(14, 'Tomás', 'González', 'tomas.gonzalez@example.com', '9012345678', 5),
(15, 'Nadia', 'Vargas', 'nadia.vargas@example.com', '0123456789', 5),
(16, 'Samuel', 'Reyes', 'samuel.reyes@example.com', '1234567890', 6),
(17, 'Lucía', 'Hurtado', 'lucia.hurtado@example.com', '2345678901', 6),
(18, 'Gustavo', 'Cervantes', 'gustavo.cervantes@example.com', '3456789012', 6),
(19, 'Natalia', 'Salazar', 'natalia.salazar@example.com', '4567890123', 7),
(20, 'Leonardo', 'Méndez', 'leonardo.mendez@example.com', '5678901234', 7),
(21, 'Patricia', 'Quintero', 'patricia.quintero@example.com', '6789012345', 7),
(22, 'Felipe', 'Córdoba', 'felipe.cordoba@example.com', '7890123456', 8),
(23, 'Santiago', 'Aguirre', 'santiago.aguirre@example.com', '8901234567', 8),
(24, 'Andrea', 'Paniagua', 'andrea.paniagua@example.com', '9012345678', 8);
