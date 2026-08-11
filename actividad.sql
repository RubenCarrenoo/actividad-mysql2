create database tienda_virtual ;

use tienda_virtual;

CREATE TABLE productos ( 
    id INT , 
    nombre VARCHAR(100), 
    precio int,
    PRIMARY KEY (id) 
);

INSERT INTO facturas (id,nombre,precio) VALUES 
('1','Marcela ', 5000), 
('2','Nicolas ', 3000), 
('3','Tomas ', 10000), 
('4','Pedro ', 8000), 
('5','Javier ', 7000); 

select * from productos ;


DELIMITER // 
 
CREATE PROCEDURE productos( 
    IN productos VARCHAR(50), 
    OUT p_total INT 
) 
BEGIN 
    SELECT COALESCE(SUM(stock), 0) 
    INTO p_total 
    FROM herramientas 
    WHERE categoria = productos; 
END // 
 
DELIMITER ; 
 
CALL stock_categoria('electricas', @total); 
SELECT @total;


DELIMITER // 
 
CREATE PROCEDURE agregar_puntos( 
    IN p_id_compra INT, 
    INOUT p_total INT 
) 
BEGIN 
    DECLARE v_puntos INT; 
 
    SELECT puntos_generados 
    INTO v_puntos 
    FROM compras 
    WHERE id = p_id_compra; 
 
    SET p_total = p_total + v_puntos; 
END // 
 
DELIMITER ; 
 
SET @total = 0; 
 
CALL agregar_puntos(1, @total); 
CALL agregar_puntos(2, @total)

