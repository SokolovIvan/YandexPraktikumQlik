Select  2020 as [first_day_year]
		,round(child_visit, 0) as child_visit
        ,round(child_quene,0) as child_quene
        ,child_visit_grow_up.mo_id
        ,child_visit_grow_up.age
	   from 
-- Считаем детей который ходят в ДС
(SELECT 
      sum ([child_visitng]) as child_visit
      ,u.mo_id
      ,[age]
  FROM [AnalitDB].[edu].[KG_Children_visitng_by_age] vba
  join [AnalitDB].[edu].[KG_Unit] u on u.id = vba.unit_id
  where [date] = '2020-01-01'
  group by u.mo_id, [age]) child_visit_grow_up

-- Считаем количество детей которые в очереди
left join

(SELECT 
      count ([child_id]) as child_quene
     ,u.mo_id
      ,[age]
  FROM [AnalitDB].[edu].[KG_Child_quene_by_age] qba
  join [AnalitDB].[edu].[KG_Unit] u on u.id = qba.unit_id
    where [date] = '2020-01-01'
  group by u.mo_id, [age]) child_quene_grow_up
  on child_visit_grow_up.mo_id = child_quene_grow_up.mo_id and child_visit_grow_up.age = child_quene_grow_up.age
 
 union

 Select  2020 as [first_day_year]
		,child_visit
       ,child_quene
	  ,child_quene_grow_up.mo_id
      ,child_quene_grow_up.age
	   from 
-- Считаем детей который ходят в ДС
(SELECT 
      sum ([child_visitng]) as child_visit
      ,u.mo_id
      ,[age] as age
  FROM [AnalitDB].[edu].[KG_Children_visitng_by_age] vba
  join [AnalitDB].[edu].[KG_Unit] u on u.id = vba.unit_id
  where [date] = '2020-01-01'
  group by u.mo_id, [age]) child_visit_grow_up

-- Считаем количество детей которые в очереди
full join

(SELECT 
      count ([child_id]) as child_quene
     ,u.mo_id
      ,[age] as age
  FROM [AnalitDB].[edu].[KG_Child_quene_by_age] qba
  join [AnalitDB].[edu].[KG_Unit] u on u.id = qba.unit_id
    where [date] = '2020-01-01'
  group by u.mo_id, [age]) child_quene_grow_up
  on child_visit_grow_up.mo_id = child_quene_grow_up.mo_id and child_visit_grow_up.age = child_quene_grow_up.age
 where child_visit_grow_up.mo_id is null
 order by mo_id, age