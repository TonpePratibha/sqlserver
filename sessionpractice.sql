select * from notes;
select * from notes order by id desc offset 1 rows fetch next 5 rows only;

select * from users;

select * from users where Name like 'p%';

var users=_context.users.Where(u=>u.Name.Startswith("p")).ToList();


