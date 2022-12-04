-- 1 Фамилии, имена, емейл, номер телефона и полный адрес всех студентов.
select last_name, first_name, email, phone, (select country|| ' ' ||city|| ' ' ||street|| ' ' ||house
                                             from adress a
                                             where a.adress_id=p.adress_id) as adress
from persons p
join contacts c on p.person_id = c.persons_id
where p.role='student';

-- 2 Среднее время потраченное на уроки каждым_ой студеном_кой (выводим фамилию, имя, емейл, среднее время на уроках).
select last_name, first_name, email, round(avg(time), 2)
from persons p
join contacts c on p.person_id = c.persons_id
join person_lesson pl on p.person_id = pl.person_id
join lessons l on l.lesson_id = pl.lesson_id
where p.role='student'
group by last_name, first_name, email;

-- 3 Запрос позволяющий проверить есть ли в группе однофамильцы (не важно студенты или учителя).  Вывести все повторяющиеся фамилии и их количество.
select last_name, count() as count
from persons
group by last_name
having count > 1;

-- 4 Запрос позволяющий проверить есть ли в группе среди студентов тески. (анологично с 3.3)
select first_name, count() as count
from persons
where role='student'
group by first_name
having count > 1;

-- 5 Вывести фамилию, имя, контактные данные студента_ки - который_ая посетил_а больше всего уроков.
select first_name, last_name, email, phone, count() as count
from persons p
join contacts c on p.person_id = c.persons_id
join person_lesson pl on p.person_id = pl.person_id
join lessons l on l.lesson_id = pl.lesson_id
group by p.person_id
order by count desc
limit 1;


-- 6 Вывести фамилию, имя, контактные данные учителя - который потратил больше всего времени на уроках.
-- 7 Вывести для каждого_ой студента_ки (фамилия, имя) рекомендуемые материалы всех пройденных конкретным студентом_кой уроков.
-- 8 Вывести для каждого_ой студента_ки (фамилия, имя) уникальные рекомендуемые материалы (они не должны повторяться) всех пройденных конкретным студентом_кой уроков.
-- 9 Вывести страну в которой живут студенты посетившие больше всего уроков.
-- 10 Вывести город в котором живут студенты которые потратили больше всего время на посещения уроков.