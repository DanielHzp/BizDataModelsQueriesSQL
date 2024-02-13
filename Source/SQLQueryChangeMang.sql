/****** Script for SelectTopNRows command from SSMS  ******/


select requestDate as 'Date of request',changeManagement.CaseNumber as CaseNumber,EndTime,ChangeResponsibleDecisio.Name, productmanagement.ProductName as ProdName,activity.Name as Activity, itemsrelated.ItemDescription as item,ChangeRequested.ReasonOfChange,*--,changeManagement.bSupportCaseCreated, * 
from 
	changeManagement left join ChangeResponsibleDecisio on ChangeResponsibleDecisio.idChangeResponsibleDecisio=ChangeManagement.ChangeResponsibleDecision
	left join ProductManagement on ProductManagement.idProductManagement=ChangeManagement.ProductRelated
	left join Activity on activity.idActivity=ChangeManagement.activity
	left join ItemsRelated on ItemsRelated.idItemsRelated=ChangeManagement.ItemsRelated
	left join changeManagementImplemen on ChangeManagementImplemen.idChangeManagementImplemen=changeManagement.ImplementationContingencyP
	left join ChangeRequested on ChangeRequested.idChangeRequested=ChangeManagement.ChangeRequested
--where  
		--ChangeRequested.ReasonOfChange like '%TM25368%'
		--EndTime is null 
		--and RequestDate like '%2022%' 
		order by requestDate desc --and changeManagement.CaseNumber like '%CO-21400%'

select * from ChangeResponsibleDecisio
select * from ProductManagement
select * from  activity
select * from ItemsRelated
select * from ChangeManagement
select * from ImplementationStep
Select * from ChangeManagementImplemen
select * from RollbackProcedure
select * from TimeforRollback
SELECT * FROM RiskDescription
--select * from addi
select * from role


SELECT RequestDate AS 'DateofRequest',* FROM ChangeManagement order by RequestDate desc

select decisiondate as 'Decision date',* from ChangeCommitte order by DecisionDate desc




--Cases created from CS ticket management 

select bSupportCaseCreated,bSupportCaseCSCreated,CaseNumber,* from changemanagement where bSupportCaseCSCreated=1 --and bSupportCaseCreated=1 




select * from TASK WHERE idTask=2589