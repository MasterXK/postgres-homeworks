-- 1. Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar
create table student (student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar)

-- 2. Добавить в таблицу student колонку middle_name varchar
ALTER TABLE student ADD COLUMN middle_name varchar

-- 3. Удалить колонку middle_name
 ALTER TABLE student DROP COLUMN middle_name

-- 4. Переименовать колонку birthday в birth_date
 ALTER TABLE student RENAME COLUMN birthday TO birth_date

-- 5. Изменить тип данных колонки phone на varchar(32)
ALTER TABLE student ALTER COLUMN phone type varchar(32)

-- 6. Вставить три любых записи с автогенерацией идентификатора
INSERT INTO student(first_name, last_name, birth_date, phone)
VALUES
('Ярослав', 'Мизинцев', TO_DATE('20/02/2000', 'DD/MM/YYYY'), '89118526345'),
('Марина', 'Крышкина', TO_DATE('12/09/2001', 'DD/MM/YYYY'), '89218563545'),
('Галина', 'Возвратова', TO_DATE('01/01/2007', 'DD/MM/YYYY'), '89118526345')

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
TRUNCATE TABLE student RESTART IDENTITY;