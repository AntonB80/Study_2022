-- Создание таблицы

CREATE TABLE Phones 
(
  id INTEGER,
  manufacturer VARCHAR(20) NOT NULL,
  model VARCHAR(20) NOT NULL,
  price INTEGER NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
)

-- Заполнение таблицы

INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (1, 'Apple', 'iPhone 10XXL',99000, 17);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (2, 'Apple', 'iPhone 10L',80000, 6);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (15, 'Apple', 'iPhone 9',65000, 16);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (18, 'Apple', 'iPhone 10',75000, 3);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (21, 'Apple', 'iPhone 12 ProMaxXL',120000, 17);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (22, 'Apple', 'iPhone 10',89000, 11);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (24, 'Apple', 'iPhone 11',105000, 11);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (8, 'LG', 'D201',55000, 0);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (17, 'LG', 'D201X',75000, 15);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (10, 'Motorola', 'E398',34000, 3);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (12, 'Motorola', 'E398',34000, 15);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (14, 'Motorola', 'E398',38000, 3);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (19, 'Motorola', 'E398',38000, 9);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (23, 'Motorola', 'RZR V3',44000, 15);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (27, 'Motorola', 'RZR V10',55000, 9);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (3, 'Samsung', 'A110',30000, 6);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (5, 'Samsung', 'Galaxy XL',80000, 8);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (6, 'Samsung', 'Galaxy Big',140000, 19);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (7, 'Samsung', 'A320',50000, 11);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (13, 'Samsung', 'A100',35000, 10);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (16, 'Samsung', 'Note 100',90000, 3);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (26, 'Samsung', 'Note 100',100000, 17);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (4, 'Xiaomi', 'EP100',25000, 18);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (9, 'Xiaomi', 'EP100',30000, 18);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (11, 'Xiaomi', 'EP200',45000, 2);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (20, 'Xiaomi', 'EP300',55000, 13);
INSERT INTO Phones(id,manufacturer, model,price,quantity) VALUES (25, 'Xiaomi', 'EP300XL',65000, 4);

INSERT INTO Phones(id,manufacturer, model,price) VALUES (102, 'Apple', 'iPhone 10XXL',99000);

-- Вывести всю таблицу
SELECT * FROM phones

-- Вывести некоторые столбцы таблицу
SELECT manufacturer, model, price FROM phones

SELECT *, price * quantity AS total FROM phones

-- Сортировка
SELECT * FROM phones 
ORDER BY price 
DESC
LIMIT 5

-- Фильтрация
SELECT * FROM phones WHERE manufacturer = 'Samsung'

SELECT * FROM phones WHERE price = 100000

SELECT * FROM phones WHERE price >= 100000

SELECT * FROM phones WHERE price >= 100000 AND manufacturer = 'Samsung' AND quantity > 18

-- Вывести телефоны ценой 50к-100к
SELECT * FROM phones WHERE price >= 50000 AND price <= 100000
SELECT * FROM phones WHERE price BETWEEN 50000 AND 100000

-- Вывести все телефоны, отличные от Apple
SELECT * FROM phones WHERE manufacturer != 'Apple'

-- Вывести все телефоны Apple и Samsung
SELECT * FROM phones WHERE manufacturer IN ('Apple', 'Samsung')

-- Вывести все телефоны, отличные от Apple и Samsung
SELECT * FROM phones WHERE manufacturer NOT IN ('Apple', 'Samsung')

-- Фильтрация + сортировка
SELECT * FROM phones WHERE price > 30000 AND quantity > 5
ORDER BY price
DESC
LIMIT 7

-- Каких моделей на остатке меньше трех штук
SELECT * FROM phones WHERE quantity < 3

-- Вывести список производителей телефонов
SELECT DISTINCT(manufacturer) manufacturer FROM phones


-- Обновление данных
UPDATE phones
SET price = 55000
WHERE id = 5


-- Заменить прайс +10%, у всех кто >40тыс
UPDATE phones
SET price = price * 1.1
WHERE price > 40000

-- Вывести максимальное значение цены
SELECT price FROM phones
ORDER BY price
DESC
LIMIT 1

SELECT MAX(price) FROM phones

-- Агрегатные функции

-- Агрегатные функции 
SELECT MAX(price) FROM phones
SELECT MIN(price) FROM phones
SELECT AVG(price) FROM phones
SELECT SUM(price) FROM phones
SELECT COUNT(price) FROM phones

SELECT MIN(manufacturer) FROM phones

SELECT MIN(price), MAX(price), AVG(price), SUM(price), COUNT(price) FROM phones

-- Найти "истинное" среднее значение цены
SELECT SUM(price * quantity)/SUM(quantity) FROM phones

-- Вывести информацию о самом дорогом телефоне
SELECT * FROM phones 
ORDER BY price
DESC
LIMIT 1

-- Вывести информацию о самом дорогом телефоне ПОДЗАПРОС
SELECT * FROM phones WHERE price = (SELECT MAX(price) FROM phones)

-- Вывести информацию о телефонах с ценой, выше среденей
SELECT * FROM phones WHERE price > (SELECT SUM(price * quantity) / SUM(quantity) FROM phones)

-- Вывести информацию о телефонах с ценой, выше среденей, и с количеством меньше среднего
SELECT * FROM phones 
WHERE 
price > (SELECT SUM(price * quantity) / SUM(quantity) FROM phones)
AND 
quantity < (SELECT AVG(quantity) FROM phones)

-- Вывести количество уникальных производителей
SELECT COUNT(DISTINCT(manufacturer)) FROM phones 

-- Вывести производителей и среднюю цену за их продукцию
SELECT manufacturer, AVG(price) FROM phones
GROUP BY manufacturer

-- 
SELECT manufacturer, model, AVG(price), MIN(price), SUM(quantity) FROM phones
GROUP BY manufacturer, model

-- когда нужно вывести телефоны с одинаковой ценой
SELECT price, COUNT(model) FROM phones
GROUP BY price
HAVING COUNT(price) > 1

-- Вывести производителей и среднюю цену за их продукцию, которая больше 50000
SELECT manufacturer, ROUND(AVG(price), 0) FROM phones
GROUP BY manufacturer
HAVING AVG(price) > 50000

-- Вывести производителей и среднюю цену за их продукцию, которая больше 50000
SELECT manufacturer, ROUND(SUM(price * quantity) / SUM(quantity), 0) FROM phones WHERE quantity > 0
GROUP BY manufacturer
HAVING (SUM(price * quantity) / SUM(quantity))> 50000