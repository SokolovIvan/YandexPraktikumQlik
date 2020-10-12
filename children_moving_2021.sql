
 --  delete from  [AnalitDB].[edu].[KG_forecast_moving_2030]
   insert into  [AnalitDB].[edu].[KG_forecast_moving_2030] 


select 2030 as [year], tmp1.mo_id, tmp1.age,  tmp1.visit_end as child_visit, tmp1.quene_end as child_quene, tmp2.[add_quene], tmp2.child_enroll,
tmp3.visit_end as child_visit_grow, tmp3.quene_end as child_quene_grow, isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0) as grow_add_visit,

case when tmp1.mo_id = 1 and tmp1.age = 5 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.0126, 0)
	 when tmp1.mo_id = 4 and tmp1.age = 5 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0, 0)
	 when tmp1.mo_id = 21 and tmp1.age = 5 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.013, 0)
	 when tmp1.mo_id not in (1, 4, 21) and tmp1.age = 5 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0, 0)
	 when tmp1.mo_id = 1 and tmp1.age = 6 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.0731, 0)
	 when tmp1.mo_id = 4 and tmp1.age = 6 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.0986, 0)
	 when tmp1.mo_id = 21 and tmp1.age = 6 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.0914, 0)
	 when tmp1.mo_id not in (1, 4, 21) and tmp1.age = 6 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.0996, 0)
	 when tmp1.mo_id = 1 and tmp1.age = 7 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.93, 0)
	 when tmp1.mo_id = 4 and tmp1.age = 7 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.9148, 0)
	 when tmp1.mo_id = 21 and tmp1.age = 7 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.9605, 0)
	 when tmp1.mo_id not in (1, 4, 21) and tmp1.age = 7 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 0.9333, 0)
	 when tmp1.mo_id = 1 and tmp1.age = 8 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 1.0, 0)
	 when tmp1.mo_id = 4 and tmp1.age = 8 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 1.0, 0)
	 when tmp1.mo_id = 21 and tmp1.age = 8 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 1.0, 0)
	 when tmp1.mo_id not in (1, 4, 21) and tmp1.age = 8 then round((isnull(tmp3.visit_end, 0) + isnull(tmp2.child_enroll, 0)) * 1.0, 0)
	 end as graduation,

	 case when tmp1.age < 4 then 
	 isnull(tmp3.quene_end, 0) + isnull(tmp2.add_quene, 0) - isnull(tmp2.child_enroll, 0)
	 else 0 end as quene_end,



	  cast(isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0) - isnull(
	 case when tmp1.mo_id = 1 and tmp1.age = 5 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.0126, 0)
	 when tmp1.mo_id = 4 and tmp1.age = 5 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0, 0)
	 when tmp1.mo_id = 21 and tmp1.age = 5 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.013, 0)
	 when tmp1.mo_id not in (1, 4, 21) and tmp1.age = 5 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0, 0)
	 when tmp1.mo_id = 1 and tmp1.age = 6 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.0731, 0)
	 when tmp1.mo_id = 4 and tmp1.age = 6 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.0986, 0)
	 when tmp1.mo_id = 21 and tmp1.age = 6 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.0914, 0)
	 when tmp1.mo_id not in (1, 4, 21) and tmp1.age = 6 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.0996, 0)
	 when tmp1.mo_id = 1 and tmp1.age = 7 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.93, 0)
	 when tmp1.mo_id = 4 and tmp1.age = 7 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.9148, 0)
	 when tmp1.mo_id = 21 and tmp1.age = 7 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.9605, 0)
	 when tmp1.mo_id not in (1, 4, 21) and tmp1.age = 7 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 0.9333, 0)
	 when tmp1.mo_id = 1 and tmp1.age = 8 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 1.0, 0)
	 when tmp1.mo_id = 4 and tmp1.age = 8 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 1.0, 0)
	 when tmp1.mo_id = 21 and tmp1.age = 8 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 1.0, 0)
	 when tmp1.mo_id not in (1, 4, 21) and tmp1.age = 8 then round((isnull(tmp3.child_visit, 0) + isnull(tmp2.child_enroll, 0)) * 1.0, 0)
	 end, 0) 
	 +
	 isnull(case when tmp1.age >= 4 then tmp1.child_quene else 0 end, 0) as int)  as visit_end

 from [AnalitDB].[edu].[KG_forecast_moving_2029] tmp1
left join [AnalitDB].[edu].[KG_forecast_moving_2029] tmp3
on tmp1.mo_id = tmp3.mo_id and tmp1.age = tmp3.age + 1

left join 
-- начало выборки tmp2 количество детей добавляющихся в очередь и зачисляемых в ДС
(
select [moID], [age], [forecast_by_year], [forecast_quene_age0] as [add_quene]
,[forecast_quene_age0_visit_0] as child_enroll
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll]
 union all
  select [moID], [age] + 1, [forecast_by_year] + 1, [forecast_quene_age1], [forecast_quene_age0_visit_1] + [forecast_quene_age1_visit_1] as child_enroll
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll]
 union all
    select [moID], [age] + 2, [forecast_by_year] + 2, [forecast_quene_age2], [forecast_quene_age0_visit_2] + [forecast_quene_age1_visit_2] + [forecast_quene_age2_visit_2] as child_enroll
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll]
union all
   select [moID], [age] + 3, [forecast_by_year] + 3, [forecast_quene_age3], [forecast_quene_age0_visit_3] + [forecast_quene_age1_visit_3] + [forecast_quene_age2_visit_3] + [forecast_quene_age3_visit_3] as child_enroll
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll]
union all
     select [moID], [age] + 4, [forecast_by_year] + 4, [forecast_quene_age4], [forecast_quene_age4_visit_4] as child_enroll
  FROM [AnalitDB].[edu].[KG_forecast_quene_enroll]
  ) tmp2
  on tmp2.[moID] = tmp1.[mo_ID] and tmp2.[age] = tmp1.[age] and tmp2.[forecast_by_year] = 2030

  order by mo_id, age