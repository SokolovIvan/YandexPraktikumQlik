/* Код для заполнения таблицы по детям по факту по состоянию на 01.01.2020 по всем возрастам.
Заполнение детей на другие даты, имеет особенности и заполняется по-другому. Для дописывания количества детей в очередь возрастом 3 и 4 года неоходимо
снять комментарий ниже*/
-- insert into  [AnalitDB].[edu].[KG_forecast_data]

select * from (
SELECT [moID]
      ,[age]
      ,[forecast_by_year] as [year]
      ,[fqa0_quene] as [quene]
      ,[visit0] as [visit]
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll_3]

  union all 

  SELECT [moID]
      ,[age] + 1
      ,[forecast_by_year] + 1 as [year] 
      ,[fqa1_quene] as [quene]
      ,[visit1] as [visit]
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll_3]
  
  union all 

  SELECT [moID]
      ,[age] + 2
      ,[forecast_by_year] + 2 as [year]
      ,[fqa2_quene] as [quene]
      ,[visit2] as [visit]
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll_3]
    
  union all 

  SELECT [moID]
      ,[age] + 3
      ,[forecast_by_year] + 3 as [year]
      ,[fqa3_quene] as [quene]
      ,[visit3] as [visit]
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll_3]
  
  union all 

  SELECT [moID]
      ,[age] + 4
      ,[forecast_by_year] + 4 as [year]
      ,0 as [quene]
      ,[visit4] as [visit]
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll_3] ) main
  where [year] = 2020
  
  union all

  Select  child_visit_grow_up.mo_id
		,child_visit_grow_up.age
        ,2020 as [year]
		,isnull(round(child_quene,0), 0) as quene
		,isnull(round(child_visit, 0), 0) as visit
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
 where child_visit_grow_up.age >= 5

 union all

 Select  child_quene_grow_up.mo_id
		,child_quene_grow_up.age
		,2020 as [year]
		,isnull(child_visit, 0) as quene
       ,isnull(child_quene, 0) as visit
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
 where child_visit_grow_up.mo_id is null and child_visit_grow_up.age >= 5

 order by moID, [year], age

 /*
 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 993 where [moID] = 1 and age = 3

 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 447 where [moID] = 1 and age = 4

 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 13 where [moID] = 3 and age = 3

 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 7 where [moID] = 3 and age = 4

 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 140 where [moID] = 4 and age = 3

 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 115 where [moID] = 4 and age = 4

 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 1 where [moID] = 11 and age = 3

 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 2 where [moID] = 13 and age = 3

update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 2 where [moID] = 13 and age = 4

 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 2 where [moID] = 14 and age = 3

update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 4 where [moID] = 15 and age = 3

 update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 1 where [moID] = 16 and age = 3

  update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 1 where [moID] = 16 and age = 4

  update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 1 where [moID] = 20 and age = 3

  update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 1 where [moID] = 20 and age = 4

update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 58 where [moID] = 21 and age = 3

update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 11 where [moID] = 21 and age = 4

update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 2 where [moID] = 23 and age = 3

update [AnalitDB].[edu].[KG_forecast_data]
 set [quene] = 3 where [moID] = 26 and age = 3
 */