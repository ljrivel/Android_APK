CREATE DATABASE  IF NOT EXISTS `sql9645024` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `sql9645024`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: sql9.freemysqlhosting.net    Database: sql9645024
-- ------------------------------------------------------
-- Server version	5.5.62-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'sql9645024'
--
/*!50003 DROP PROCEDURE IF EXISTS `EliminarCursoPorCodigo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `EliminarCursoPorCodigo`(
    IN codigo_curso VARCHAR(20)
)
BEGIN
    DECLARE id_curso INT;

    -- Buscar el ID del curso por código
    SELECT id INTO id_curso
    FROM curso
    WHERE codigo = codigo_curso;

    IF id_curso IS NOT NULL THEN
        DELETE FROM curso
        WHERE id = id_curso;
        SELECT 'Curso eliminado correctamente.' AS mensaje;
    ELSE
        SELECT 'No se encontró un curso con código ' + codigo_curso + '.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarEstudiantePorCarnet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `EliminarEstudiantePorCarnet`(
    IN carnet_estudiante VARCHAR(20)
)
BEGIN
    DECLARE id_estudiante INT;

    -- Buscar el ID del estudiante por carnet
    SELECT id INTO id_estudiante
    FROM estudiante
    WHERE carnet = carnet_estudiante;

    IF id_estudiante IS NOT NULL THEN
        DELETE FROM estudiante
        WHERE id = id_estudiante;
        SELECT 'Estudiante eliminado correctamente.' AS mensaje;
    ELSE
        SELECT 'No se encontró un estudiante con carnet ' + carnet_estudiante + '.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarMatriculaEnCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `EliminarMatriculaEnCurso`(
    IN id_matricula INT
)
BEGIN
    DELETE FROM cursoMatriculado
    WHERE id = id_matricula;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Matrícula eliminada correctamente.' AS mensaje;
    ELSE
        SELECT 'No se encontró una matrícula con ID ' + CAST(id_matricula AS CHAR) + '.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCursoPorCodigo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `GetCursoPorCodigo`(
    IN codigo_curso VARCHAR(20)
)
BEGIN
    DECLARE curso_encontrado INT DEFAULT 0;
    
    SELECT COUNT(*) INTO curso_encontrado
    FROM curso
    WHERE codigo = codigo_curso;
    
    IF curso_encontrado = 1 THEN
        SELECT codigo, nombre, descripcion
        FROM curso
        WHERE codigo = codigo_curso;
    ELSE
        SELECT 'No se encontró un curso con el código proporcionado.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEstudiantePorCarnet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `GetEstudiantePorCarnet`(
    IN carnet_estudiante VARCHAR(20)
)
BEGIN
    DECLARE estudiante_encontrado INT DEFAULT 0;
    
    SELECT COUNT(*) INTO estudiante_encontrado
    FROM estudiante
    WHERE carnet = carnet_estudiante;
    
    IF estudiante_encontrado = 1 THEN
        SELECT carnet, nombre, apellido, email
        FROM estudiante
        WHERE carnet = carnet_estudiante;
    ELSE
        SELECT 'No se encontró un estudiante con el carnet proporcionado.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMatriculaPorID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `GetMatriculaPorID`(
    IN id_matricula INT
)
BEGIN
    DECLARE matricula_encontrada INT DEFAULT 0;
    
    SELECT COUNT(*) INTO matricula_encontrada
    FROM cursoMatriculado
    WHERE id = id_matricula;
    
    IF matricula_encontrada = 1 THEN
        SELECT cm.id, c.codigo AS codigo_curso, e.carnet AS carnet_estudiante, cm.fecha_matricula
        FROM cursoMatriculado AS cm
        JOIN curso AS c ON cm.id_curso = c.id
        JOIN estudiante AS e ON cm.id_estudiante = e.id
        WHERE cm.id = id_matricula;
    ELSE
        SELECT 'No se encontró una matrícula con el ID proporcionado.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `infoCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `infoCurso`()
BEGIN
    DECLARE num_rows INT;
    SELECT COUNT(*) INTO num_rows FROM curso;
    
    IF num_rows = 0 THEN
        SELECT 'La tabla curso está vacía.' AS mensaje;
    ELSE
        SELECT codigo, nombre, descripcion FROM curso;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `infoCursoMatriculado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `infoCursoMatriculado`()
BEGIN
    DECLARE num_rows INT;
    
    SELECT COUNT(*) INTO num_rows FROM cursoMatriculado;
    
    IF num_rows = 0 THEN
        SELECT 'La tabla cursoMatriculado está vacía.' AS mensaje;
    ELSE
        SELECT cm.id AS id_curso_matriculado, CONCAT(e.nombre, ' ', e.apellido) AS nombre_completo_estudiante, c.nombre AS nombre_curso
        FROM cursoMatriculado cm
        INNER JOIN estudiante e ON cm.id_estudiante = e.id
        INNER JOIN curso c ON cm.id_curso = c.id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `infoEstudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `infoEstudiante`()
BEGIN
    DECLARE num_rows INT;
    SELECT COUNT(*) INTO num_rows FROM estudiante;
    
    IF num_rows = 0 THEN
        SELECT 'La tabla estudiante está vacía.' AS mensaje;
    ELSE
        SELECT id, nombre, apellido, email, carnet FROM estudiante;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `InsertarCurso`(
    IN codigo_curso VARCHAR(20),
    IN nombre_curso VARCHAR(255),
    IN descripcion_curso TEXT
)
BEGIN
    DECLARE curso_existente INT;

    -- Verificar si el curso ya existe
    SELECT COUNT(*) INTO curso_existente
    FROM curso
    WHERE codigo = codigo_curso;

    -- Si el curso no existe, realizar la inserción
    IF curso_existente = 0 THEN
        INSERT INTO curso (codigo, nombre, descripcion)
        VALUES (codigo_curso, nombre_curso, descripcion_curso);
        SELECT 'Datos insertados en la tabla curso correctamente.' AS mensaje;
    ELSE
        SELECT 'El curso ya existe en la tabla curso.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarEstudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `InsertarEstudiante`(
    IN nombre_estudiante VARCHAR(255),
    IN apellido_estudiante VARCHAR(255),
    IN email_estudiante VARCHAR(255),
    IN carnet_estudiante VARCHAR(20)
)
BEGIN
    DECLARE estudiante_existente INT;

    -- Verificar si el estudiante ya existe
    SELECT COUNT(*) INTO estudiante_existente
    FROM estudiante
    WHERE carnet = carnet_estudiante;

    -- Si el estudiante no existe, realizar la inserción
    IF estudiante_existente = 0 THEN
        INSERT INTO estudiante (nombre, apellido, email, carnet)
        VALUES (nombre_estudiante, apellido_estudiante, email_estudiante, carnet_estudiante);
        SELECT 'Datos insertados en la tabla estudiante correctamente.' AS mensaje;
    ELSE
        SELECT 'El estudiante ya existe en la tabla estudiante.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarMatriculaConCodigoCarnet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `InsertarMatriculaConCodigoCarnet`(
    IN codigo_curso VARCHAR(20),
    IN carnet_estudiante VARCHAR(20)
)
BEGIN
    DECLARE id_curso INT;
    DECLARE id_estudiante INT;

    -- Inicializar variables
    SET id_curso = NULL;
    SET id_estudiante = NULL;

    -- Buscar el ID del curso por su código
    SELECT id INTO id_curso
    FROM curso
    WHERE codigo = codigo_curso;
    
    -- Buscar el ID del estudiante por su carnet
    SELECT id INTO id_estudiante
    FROM estudiante
    WHERE carnet = carnet_estudiante;

    IF id_curso IS NOT NULL AND id_estudiante IS NOT NULL THEN
        -- Insertar en la tabla cursoMatriculado con la fecha actual
        INSERT INTO cursoMatriculado (id_estudiante, id_curso, fecha_matricula)
        VALUES (id_estudiante, id_curso, CURDATE());
        SELECT 'Matrícula insertada correctamente.' AS mensaje;
    ELSE
        SELECT 'No se encontró un curso con el código o un estudiante con el carnet proporcionado.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ModificarCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `ModificarCurso`(
    IN id_codigo VARCHAR(20),
    IN nuevo_nombre_curso VARCHAR(255),
    IN nueva_descripcion_curso TEXT
)
BEGIN
    UPDATE curso
    SET nombre = nuevo_nombre_curso, descripcion = nueva_descripcion_curso
    WHERE codigo = id_codigo;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Curso modificado correctamente.' AS mensaje;
    ELSE
        SELECT 'El curso con ID ' + CAST(id_curso AS CHAR) + ' no fue encontrado.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ModificarEstudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `ModificarEstudiante`(
    IN nuevo_nombre VARCHAR(255),
    IN nuevo_apellido VARCHAR(255),
    IN nuevo_email VARCHAR(255),
    IN carnet_estudiante VARCHAR(20)
)
BEGIN
    UPDATE estudiante
    SET nombre = nuevo_nombre, apellido = nuevo_apellido, email = nuevo_email
    WHERE carnet = carnet_estudiante;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Estudiante modificado correctamente.' AS mensaje;
    ELSE
        SELECT 'El estudiante con ID ' + CAST(id_estudiante AS CHAR) + ' no fue encontrado.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ModificarFechaMatricula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `ModificarFechaMatricula`(
    IN id_matricula INT,
    IN nueva_fecha_matricula DATE
)
BEGIN
    UPDATE cursoMatriculado
    SET fecha_matricula = nueva_fecha_matricula
    WHERE id = id_matricula;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Fecha de matrícula modificada correctamente.' AS mensaje;
    ELSE
        SELECT 'No se encontró una matrícula con ID ' + CAST(id_matricula AS CHAR) + '.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MostrarCursosPorCarnet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `MostrarCursosPorCarnet`(IN estudiante_carnet VARCHAR(20))
BEGIN
    DECLARE estudiante_count INT;
    
    SELECT COUNT(*) INTO estudiante_count FROM estudiante WHERE carnet = estudiante_carnet;
    
    IF estudiante_count = 0 THEN
        SELECT 'El estudiante con el carnet especificado no existe.' AS mensaje;
    ELSE
        SELECT c.nombre AS nombre_curso, c.descripcion AS descripcion_curso
        FROM cursoMatriculado cm
        INNER JOIN curso c ON cm.id_curso = c.id
        INNER JOIN estudiante e ON cm.id_estudiante = e.id
        WHERE e.carnet = estudiante_carnet;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MostrarCursosPorID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `MostrarCursosPorID`(IN estudiante_id INT)
BEGIN
    DECLARE estudiante_count INT;
    
    SELECT COUNT(*) INTO estudiante_count FROM estudiante WHERE id = estudiante_id;
    
    IF estudiante_count = 0 THEN
        SELECT 'El estudiante con el ID especificado no existe.' AS mensaje;
    ELSE
        SELECT c.nombre AS nombre_curso, c.descripcion AS descripcion_curso
        FROM cursoMatriculado cm
        INNER JOIN curso c ON cm.id_curso = c.id
        WHERE cm.id_estudiante = estudiante_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerificarMatriculaExistente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`sql9645024`@`%` PROCEDURE `VerificarMatriculaExistente`(
    IN codigo_curso VARCHAR(20),
    IN carnet_estudiante VARCHAR(20),
    OUT matriculado_existente BOOLEAN
)
BEGIN
    DECLARE id_curso INT;
    DECLARE id_estudiante INT;

    -- Inicializar la variable de salida
    SET matriculado_existente = FALSE;

    -- Buscar el ID del curso por su código
    SELECT id INTO id_curso
    FROM curso
    WHERE codigo = codigo_curso
    LIMIT 1;

    -- Buscar el ID del estudiante por su carnet
    SELECT id INTO id_estudiante
    FROM estudiante
    WHERE carnet = carnet_estudiante
    LIMIT 1;

    -- Verificar si el curso y el estudiante existen
    IF id_curso IS NOT NULL AND id_estudiante IS NOT NULL THEN
        -- Verificar si el estudiante ya está matriculado en el curso
        IF EXISTS (
            SELECT 1
            FROM cursoMatriculado
            WHERE id_estudiante = id_estudiante AND id_curso = id_curso
            LIMIT 1
        ) THEN
            SET matriculado_existente = TRUE;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-09 19:24:18
