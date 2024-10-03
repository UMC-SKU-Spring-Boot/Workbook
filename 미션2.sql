# 1. 멤버 미션 조회 쿼리(페이징 포함)
select mm.*, s.name as store_name from member_mission as mm
join mission as m on mm.mission_id = m.id
join store s on m.store_id = s.id
where mm.created_at <
    (select created_at from member_mission where id = 3)
    and mm.id < 3
order by mm.id desc limit 15;

# 2. 리뷰 조회 쿼리
select m.name, r.body, r.score, r.created_at, r.updated_at
from review as r
left join member as m
on r.member_id = m.id;

# 3. 홈 화면 조회 쿼리 + 지역 미션(페이징 포함)
# 포인트, 지역
select point, spec_address from member where id = 1;
# 미션 성공 개수
select count(*) from member_mission where member_id = 1 and status like '성공';
# 지역 미션
select m.*, s.name as store_name from mission as m
join store as s on m.store_id = s.id
join region as r on s.region_id = r.id
join member as mem on r.name = mem.spec_address
where
    mem.id = 1 and
    m.deadline > NOW() and
    m.created_at < (select created_at from member_mission where id = 3) and
    m.id < 3
order by m.id desc limit 15;

# 4. 마이 페이지 조회 쿼리
select * from mission as m
    join store as s on m.store_id = s.id
    join member as mem on s.region_id = mem.spec_address
         where mem.id = 1 and (m.created_at < (select created_at mission where id = 3) and m.id < 3)
order by m.id desc limit 15;