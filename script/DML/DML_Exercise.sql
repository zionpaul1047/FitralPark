insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 1, 1, 1, default, default, default, default);
insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 1, 5, NULL, default, default, default, default);
insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 1, 6, NULL, default, default, default, default);
insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 2, 2, NULL, default, default, default, default);
insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 2, 7, NULL, default, default, default, default);
insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 2, 8, NULL, default, default, default, default);
insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 3, 3, NULL, default, default, default, default);
insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 3, 9, NULL, default, default, default, default);
insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 3, 10, NULL, default, default, default, default);
insert into routine_exercise (routine_exercise_no, routine_no, exercise_no, custom_exercise_no, sets, reps_per_set, exercise_time, weight)
values (seq_routine_exercise_no.nextVal, 4, 4, NULL, default, default, default, default);

commit;

select * from member;

update exercise_part set exercise_part_name = '하체' where exercise_part_no = 1;
update exercise_part set exercise_part_name = '가슴' where exercise_part_no = 2;
update exercise_part set exercise_part_name = '등' where exercise_part_no = 3;
update exercise_part set exercise_part_name = '어깨' where exercise_part_no = 4;
update exercise_part set exercise_part_name = '팔' where exercise_part_no = 5;
update exercise_part set exercise_part_name = '역도' where exercise_part_no = 6;
update exercise_part set exercise_part_name = '복근' where exercise_part_no = 7;
update exercise_part set exercise_part_name = '기타' where exercise_part_no = 8;
update exercise_part set exercise_part_name = '유산소' where exercise_part_no = 9;
update routine set views = 10012 where routine_no = 1;
update routine set creation_date = TO_DATE('2025-03-31', 'YYYY-MM-DD') where routine_no = 2;
update routine set creation_date = TO_DATE('2025-03-31', 'YYYY-MM-DD') where routine_no = 3;
update routine set creation_date = TO_DATE('2025-03-31', 'YYYY-MM-DD')  where routine_no = 4;