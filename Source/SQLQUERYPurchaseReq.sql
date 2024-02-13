select purchaserequisition.IntervaloNochiveApprover,* from PurchaseRequisition where purchaserequisition.IntervaloNochiveApprover is not null

BEGIN --PR: Casos con sus respectivas categorias de HR 

SELECT 
		Currentpurchaseapprover,radnumber,bisHRPurchase,kpHRPurchaseCategoryL2,kpHRPurchaseCategoryL1,* 
FROM 
		PurchaseRequisition left join pHRCategoryL2   on pHRCategoryL2.idpHRCategoryL2=PurchaseRequisition.kpHRPurchaseCategoryL2
order BY idPurchaseRequisition DESC
END;





BEGIN --PR: Histórico de la matriz de aprobadores con su nivel y monto de aprobación

select approvalindex as 'Approval Index',fullName,Approver,wfuser.enabled as 'Enabled?',* 
from 
	Purchaseapprover left join WFUSER on wfuser.idUser=Purchaseapprover.Approver 
	left join PurchaseRequisition on purchaserequisition.idPurchaseRequisition=Purchaseapprover.PurchaseRequisition
--where wfuser.fullname like '%edgar giovanny%' and purchaserequisition.RadNumber='CO-120944'
order by ApprovalIndex asc
END








BEGIN --PR: Usuarios con sus respectivos niveles y montos de aprobación 

SELECT wfuser.fullName,Purchaseapprovallevel.Approvallevel,PurchaseApprovalRanges.Maxamount,PurchaseApprovalRanges.Code,* 

FROM WFUSER left join Purchaseapprovallevel on Purchaseapprovallevel.idPurchaseapprovallevel=wfuser.idPurchaseapprovallevel
left join PurchaseApprovalRanges on PurchaseApprovalRanges.Purchaseapprovallevel=Purchaseapprovallevel.idPurchaseapprovallevel
left join Currency on Currency.idCurrency=PurchaseApprovalRanges.Currency

WHERE WFUSER.ENABLED=1 AND PurchaseApprovalRanges.Code like '%USD%'
END













BEGIN --PR: Aprobadores de un caso en particular para hacer trace a la regla set requisition approvers
select * from Purchaseapprovallevel
select * from PurchaseApprovalRanges
select * from Purchaseapprover

select * from workitem
select * from wfcase

--Query purchase approvals log entity
select	
		purchaserequisition.RadNumber,purchaserequisition.Purchaser,purchaserequisition.OtherUser,wfuser.fullName as 'Case Requester',
		purchaserequisition.ReportingForOtherUser,
		--approvalindex as 'Approval Index', purchaserequisition.RequestDate,
		wfApprover.fullName as 'Approver name', PurchaseApprovalLog.Approver,
		wfApprover.enabled as 'Enabled?',
		wfApprover.idBossUser as 'Approver boss',
		purchaserequisition.RequisitionValue,
		purchaserequisition.IsthisaMarketingpurcha,
		wfApprover.idPurchaseapprovallevel,Purchaseapprovallevel.Code,
		purchaseapprovalranges.Maxamount,PurchaseApprovalRanges.Code,expensecurrency.Symbol,*  --workitem.wiEntryDate,workitem.wiSolutionDate,-- * 
from 
	PurchaseApprovalLog left join WFUSER wfApprover on wfApprover.idUser=PurchaseApprovalLog.Approver 
	left join PurchaseRequisition on purchaserequisition.idPurchaseRequisition=PurchaseApprovalLog.PurchaseRequisition
	left join Purchaseapprovallevel on Purchaseapprovallevel.idPurchaseapprovallevel=wfApprover.idPurchaseapprovallevel 
	left join PurchaseApprovalRanges on PurchaseApprovalRanges.Purchaseapprovallevel=wfApprover.idPurchaseapprovallevel
	left join WFUSER on purchaserequisition.OtherUser=wfuser.idUser
	left join wfcase on wfcase.idcase=purchaserequisition.idCase
	left join workflow on wfcase.idWorkflow=workflow.idWorkflow
	left join ExpenseCurrency on purchaserequisition.RequisitionCurrency=expensecurrency.idExpenseCurrency
	--left join workitem on workitem.idcase=wfcase.idCase
	--left join workitemstate on workitem.idworkitemstate=workitemstate.idworkitemstate

where PurchaseApprovalRanges.Code like'%USD%' --wfuser.fullname like '%Stephan%' --purchaserequisition.RadNumber='CO-213' and PurchaseApprovalRanges.Code like '%USD%'
order by  purchaserequisition.RequestDate DESC--, Purchaseapprover.ApprovalIndex ASC








--Query purchase approvers entity
select	
		purchaserequisition.RadNumber,purchaserequisition.Purchaser,purchaserequisition.OtherUser,wfuser.fullName as 'Case Requester',
		purchaserequisition.ReportingForOtherUser,
		approvalindex as 'Approval Index', purchaserequisition.RequestDate,
		wfApprover.fullName as 'Approver name', purchaseapprover.Approver,
		wfApprover.enabled as 'Enabled?',
		wfApprover.idBossUser as 'Approver boss',
		purchaserequisition.RequisitionValue,
		purchaserequisition.IsthisaMarketingpurcha,
		wfApprover.idPurchaseapprovallevel,Purchaseapprovallevel.Code,
		purchaseapprovalranges.Maxamount,PurchaseApprovalRanges.Code,expensecurrency.Symbol,*  --workitem.wiEntryDate,workitem.wiSolutionDate,-- * 
from 
	Purchaseapprover left join WFUSER wfApprover on wfApprover.idUser=Purchaseapprover.Approver 
	left join PurchaseRequisition on purchaserequisition.idPurchaseRequisition=Purchaseapprover.PurchaseRequisition
	left join Purchaseapprovallevel on Purchaseapprovallevel.idPurchaseapprovallevel=wfApprover.idPurchaseapprovallevel 
	left join PurchaseApprovalRanges on PurchaseApprovalRanges.Purchaseapprovallevel=wfApprover.idPurchaseapprovallevel
	left join WFUSER on purchaserequisition.OtherUser=wfuser.idUser
	left join wfcase on wfcase.idcase=purchaserequisition.idCase
	left join workflow on wfcase.idWorkflow=workflow.idWorkflow
	left join ExpenseCurrency on purchaserequisition.RequisitionCurrency=expensecurrency.idExpenseCurrency
	--left join workitem on workitem.idcase=wfcase.idCase
	--left join workitemstate on workitem.idworkitemstate=workitemstate.idworkitemstate

where PurchaseApprovalRanges.Code like'%USD%' 
order by  purchaserequisition.RequestDate DESC--, Purchaseapprover.ApprovalIndex ASC

--wfuser.fullname like '%%' --purchaserequisition.RadNumber='CO-213' and PurchaseApprovalRanges.Code like '%USD%'



select * from ExpenseCurrency

END


















BEGIN --PR: Tabla (process entity) purchase requisition con todos los casos y actividades en las que se encuentran 

select	purchaserequisition.requestdate as RequestDate,purchaserequisition.RadNumber as CaseNumber,wiEntryDate, 
		purchasetype.Name as PurchaseType, BlanketPOCategory.Name as PurchaseCategory,PurchaseRequisition.bRampCardUsed as IsRampPurchase,legalterms.Name as LegalTermsName, companyeu.Name as CompanyEU,BizagiCorpCompany.Name as BizagiCorpCompany,--purchaserequisition.kmContractDetails,
		wfuser.userName as 'PurchaseCreator',
		task.tskDisplayName,
		workflow.wfVersion, workflow.wfActive,
		RequisitionValue,
		invoiceuploader,purchaser,purchaserequisition.OtherUser,itmanager,purchaserequisition.company,task.tskDuration,purchaserequisition.kmProcessData,PurchaseRequisition.kmContractDetails,PurchaseCategoryLevel2.isITrelated,* 

from	PurchaseRequisition left join wfcase on wfcase.idcase=purchaserequisition.idCase
		left join purchasetype on purchasetype.idpurchasetype=purchaserequisition.PurchaseType
		left join companyeu on companyeu.idcompanyeu=purchaserequisition.Company
		left join BizagiCorpCompany on BizagiCorpCompany.idBizagiCorpCompany=PurchaseRequisition.BizagiCorpCompany
		left join legalterms on legalterms.idlegalterms=purchaserequisition.LegalTerms
		left join BlanketPOCategory on purchaserequisition.PurchaseCategory=BlanketPOCategory.idBlanketPOCategory
		left join workitem on workitem.idcase=wfcase.idCase
		left join task on task.idtask=workitem.idtask
		--left join employee on employee.idEmployee=purchaserequisition.purchaser
		left join wfuser on wfuser.iduser=purchaserequisition.OtherUser
		left join workflow on wfcase.idWorkflow=workflow.idWorkflow
		left join WFCLASS on wfclass.idWfClass=WORKFLOW.idWFClass
		left join PurchaseCategoryLevel2 on PurchaseCategoryLevel2.idPurchaseCategoryLevel2=purchaserequisition.PurchaseCategorylvl2
where	task.tskDisplayName is not null 
		and task.tskDisplayName NOT LIKE '%cancel%' and task.tskDisplayName NOT LIKE '%avoid%' and task.tskDisplayName NOT LIKE '%close%'
		 and task.tskDuration!=0
		 --and purchaserequisition.radnumber=''
		 --and PurchaseRequisition.kmContractDetails='155'
		 --and PurchaseRequisition.RecurringPurchase='true'
		-- and workflow.wfVersion='2.6'
		--and 
		--and BizagiCorpCompany.Name like '%Bizagi Group%'
		--and companyeu.Name is null--and purchaserequisition.radnumber='CO-103894'--and task.tskDisplayName like '%purchase order%' and purchaserequisition.RadNumber='CO-'
--order by purchaserequisition.requestdate desc

END




select * from mPRProcessData

select * from mContractDetails where mContractDetails.dContractEndDate IS NOT NULL

select purchaserequisition.RadNumber,* 
from mContractDetails left join purchaserequisition on purchaserequisition.idPurchaseRequisition = mContractDetails.kmContractPR 
where mContractDetails.bIsSaaSPO = 'true' and mContractDetails.dContractEndDate IS NOT NULL





select * from purchaserequisition 

select * from mCurrentCaseStatus
select * from mAdditionalInvPaym
select * from RequisitionItems where requisitionitems.PurchaseRequisition='2602'
select * from purchaserequisition where purchaserequisition.idPurchaseRequisition='702'


select * from purchaserequisition where purchaserequisition.RecurringPurchase='true'
select * from requisitionitems






BEGIN --PR: Tabla (process entity) purchase requisition con todos los casos CERRADOS

select	purchaserequisition.requestdate as RequestDate,purchaserequisition.RadNumber as CaseNumber,wiEntryDate, 
		purchasetype.Name as PurchaseType, BlanketPOCategory.Name as PurchaseCategory,
		PurchaseRequisition.bRampCardUsed as IsRampPurchase,
		legalterms.Name as LegalTermsName,
		companyeu.Name as CompanyEU,BizagiCorpCompany.Name as BizagiCorpCompany,--purchaserequisition.kmContractDetails,
		wfuser.userName as 'PurchaseCreator',
		task.tskDisplayName,
		workflow.wfVersion, workflow.wfActive,
		RequisitionValue,
		invoiceuploader,purchaser,purchaserequisition.OtherUser,itmanager,
		purchaserequisition.company,
		task.tskDuration,* 

from	PurchaseRequisition left join wfcase on wfcase.idcase=purchaserequisition.idCase
		left join purchasetype on purchasetype.idpurchasetype=purchaserequisition.PurchaseType
		left join companyeu on companyeu.idcompanyeu=purchaserequisition.Company
		left join BizagiCorpCompany on BizagiCorpCompany.idBizagiCorpCompany=PurchaseRequisition.BizagiCorpCompany
		left join legalterms on legalterms.idlegalterms=purchaserequisition.LegalTerms
		left join BlanketPOCategory on purchaserequisition.PurchaseCategory=BlanketPOCategory.idBlanketPOCategory
		left join workitem on workitem.idcase=wfcase.idCase
		left join task on task.idtask=workitem.idtask
		--left join employee on employee.idEmployee=purchaserequisition.purchaser
		left join wfuser on wfuser.iduser=purchaserequisition.OtherUser
		left join workflow on wfcase.idWorkflow=workflow.idWorkflow
		left join WFCLASS on wfclass.idWfClass=WORKFLOW.idWFClass
--Atributo CaseTotalDays deja de ser nulo solamente cuando el proceso pasa por los eventos terminales: PO subprocess y Confirm invoice received
where	PurchaseRequisition.CaseTotalDays is not null
		--purchaserequisition.radnumber='CO-125312'
		--task.tskDisplayName like '%End%' --and task.tskName like '%Event%'
		and workflow.wfVersion='2.6'
		and task.tskDisplayName like'%Modify Purchase Information%'
		--and PurchaseRequisition.RecurringPurchase= 'true'
		--and BizagiCorpCompany.Name like '% .... %'
		--and companyeu.Name is null--and purchaserequisition.radnumber='CO- ... '--and task.tskDisplayName like '%purchase order%'
order by purchaserequisition.requestdate desc

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END











BEGIN --PR: Tablas paramétricas en PR 


select * from legalterms
select * from employee join wfuser on wfuser.iduser=employee.idemployee
SELECT * FROM RequisitionItems
SELECT * FROM CommissionBreakdownList
-- BlanketPOCategory refers to purchase categorys (Non po, Standard or Open PO) request type attribute
select *  from BlanketPOCategory

--Item status attribute in selected items collection (purchase requisition invoices)
select * from POtemStatus

--Search items of purchase requisition invoices subprocess
select * from blanketPOinvoice

SELECT * FROM PurchaseRequisitionEmail
select * from Purchasetype
select * from PurchasePaymentMethod
select * from companyEU
select * from BizagiCorpCompany
select * from PurchaseRequisition



select * from PurchaseRequisitionStatu
--Consulta tabla centro de costo y relaciones----------------------------------------------------------------------------------------------

select * from CC_CostCentre
SELECT * FROM CC_Project
select * from CC_Area join CC_ExpenseGroup on CC_Area.ExpenseGroup=CC_ExpenseGroup.idCC_ExpenseGroup
SELECT * FROM CC_ExpenseGroup

select * from TASK


END---




--Consulta los items de todas las compras reurrentes-------------------------------------------------------------------------------------------
SELECT requisitionitems.idrequisitionitems,
		requisitionitems.Description,
		requisitionitems.PurchaseRequisition,
		requisitionitems.EndDate,
		requisitionitems.totalvalue,
		purchaserequisition.RadNumber
		
FROM 
	RequisitionItems left join PurchaseRequisition on purchaserequisition.idPurchaseRequisition=requisitionitems.PurchaseRequisition

WHERE
	purchaserequisition.RecurringPurchase='true'
	and requisitionitems.EndDate IS NOT NULL

ORDER BY
	requisitionitems.purchaserequisition DESC
	













BEGIN --PR: Purchase assistant (Buyer) encargado de las actividades Analyze y Quote
select * from CompanyEU
select roleDisplayName,PurchaseAsistantAssignme.UserRole,* 
from	PurchaseAsistantAssignme left join CompanyEU on companyeu.idCompanyEU=PurchaseAsistantAssignme.CompanyOfRequisition
		left join ROLE on role.idrole=PurchaseAsistantAssignme.UserRole
END

--------------------------------------------------------------------------------------------------------------------------------------------------------
select * from PurchaseDeptDecision
select * from SecondAnalysisPurchaseDe













BEGIN --PR: Categorias generales anidadas 

select * from PurchaseCategoryLevel2 
select * from PurchaseCategoryLevel1


SELECT isITrelated,PurchaseCategoryLevel1.name as 'level1Category', PurchaseCategoryLevel2.name as 'level2Category', * 
from PurchaseCategoryLevel1 left joiN PurchaseCategoryLevel2 
ON PurchaseCategoryLevel1.idPurchaseCategoryLevel1=PurchaseCategoryLevel2.Categorylevel1




--PR: IT approval categories that can be selected

SELECT RequestCategory.Name,* from RequestSubCategory left join RequestCategory on RequestSubCategory.Category=RequestCategory.idRequestCategory
select * from RequestCategory






END

BEGIN --PR: Categorias HR anidadas

select * from HRPurchaseCategoryL1
select * from pHRCategoryL2
select pHRCategoryL2.sName as "HR lvl 2 category",HRPurchaseCategoryL1.sName as "HR lvl 1 category",* 
from pHRCategoryL2 left join HRPurchaseCategoryL1 on pHRCategoryL2.kpHRPurchaseCategoryL1=HRPurchaseCategoryL1.idHRPurchaseCategoryL1
where HRPurchaseCategoryL1.sName like '%recruitment%'
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END



















BEGIN --PR: Casos que han entrado a legal review con su legal request type asociado 

select * from LegalRequestType

select	contractmanagement.PurchaseRequisitionCaseNum,
		legalRequestTYPE.Name,
		LegalRequestType,
		purchaserequisition.LegalTriageDecision,* 
from	ContractManagement left join LegalRequestType   on LegalRequestType.idLegalRequestType=ContractManagement.LegalRequestType
		left join PurchaseRequisition                   on purchaserequisition.idPurchaseRequisition=contractmanagement.PurchaseRequisitionID
where	PurchaseRequisitionCaseNum is not null and purchaserequisition.LegalTriageDecision=1 --and legalRequestTYPE.Name!= 'Supplier agreement'



-- Cuenta todos los tipo de legal request ---------------------------------------------------------------------------------------------------------------

select count(legalRequestTYPE.Name), legalRequestTYPE.Name
from	ContractManagement left join LegalRequestType on LegalRequestType.idLegalRequestType=ContractManagement.LegalRequestType
--where	PurchaseRequisitionCaseNum is not null
group by legalRequestTYPE.Name

select legalrequesttype.name,contractmanagement.PurchaseRequisitionID,*
from ContractManagement left join LegalRequestType on LegalRequestType.idLegalRequestType=ContractManagement.LegalRequestType
where	legalrequesttype.name  like '%supplier%' and requestdate like '%2022%'

-----------------------------------------------------------------------------------------------------------------------------------------------------------
END











BEGIN --PR: Tabla que almacena la info de contacto de los proveedores de PR 
select  supplier.TaxIDNumber,supplier.BusinessName,supplier.Address,supplier.country,supplier.contactname,supplier.contactemail,supplier.PhoneNumber,supplier.city,supplier.vatid,* from supplier WHERE idSupplier=89437
SELECT * FROM PurchaseSecurityInform
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END














BEGIN --PR: Eventos activos "Set Security Decision" Seguridad en PR 

select * from TASK where tskdisplayname like '%set security d%'
select * from WORKITEM where idTask = 15419
select radNumber, * from WFCASE where idCase in (select idCase from WORKITEM where idTask = 15419)

SELECT TASK.tskdisplayname,TASK.idTask, WFCASE.radNumber,* FROM TASK left join WORKITEM on WORKITEM.idTask=TASK.idTask left join WFCASE on WFCASE.idCase=WORKITEM.idCase
WHERE TASK.tskdisplayname like '%set security d%' 

END






BEGIN --PR: Search Bizagi Corp Companys Expense report cases vs. PR cases

Select ExpenseReport.kpBizagiCorpCompany,BizagiCorpCompany.Name,* from ExpenseReport left join BizagiCorpCompany on ExpenseReport.kpBizagiCorpCompany=BizagiCorpCompany.idBizagiCorpCompany
where BizagiCorpCompany.Name like'%Bizagi Group%'

select * from BizagiCorpCompany

END






select * from workitem
SELECT * FROM WFCLASS
select * from task
SELECT * FROM WORKITEM
SELECT * FROM WORKFLOW
select * from PHASE where phase.idPhase='2042'

SELECT * FROM WFCLASS where wfClsName LIKE '%Purchase%'
select * from ATTRIB where attribDisplayName like '%Days%'
select * from ATTRIBLOG
select * from ATTRIBCHARLOG

select * from WFCASECL
select * from WORKITEMCL



SELECT WFCLASS.WFCLSDISPLAYNAME,* FROM WORKFLOW LEFT JOIN WFCLASS ON WFCLASS.IDWFCLASS=WORKFLOW.IDWFCLASS WHERE WFCLASS.WFCLSDISPLAYNAME LIKE '%Non%'












--PR eventos de finalización 

select workflow.wfVersion,wfclass.wfClsName,
(CASE	when task.tskName='Event_9' then 'Create PR timer attached end event'
		when task.tskName='Event_3' then 'Cancel PR end event'
		when task.tskName='Event_11' then 'Avoid cancellation PR end event' 
		when task.tskName='Event_7' then 'Request items stock PR end event' 
		when task.tskName='Event_13' then 'Accounting review PR end event'
		when task.tskName='Event_16' then 'Security rev rejection PR end event'
		when task.tskName='Event_4' then 'Notify rejection PR end event'		
		when task.tskName='Event_5' then 'Legal review PR end event'
		when task.tskName='Event_6' then 'Confirm invoiced received PR end event'
		when task.tskName='Event_12' then 'PO subprocess PR end event'
		when task.tskName='Event_17' then 'Avoid post PR end event'
		END) AS 'Event custom description',*
 --workitem.wiClosed,* 
from task left join workflow on workflow.idWorkflow =task.idWorkflow  right join WFCLASS on wfclass.idWfClass=workflow.idWFClass
 --join workitem on workitem.idTask=task.idTask
where  workflow.wfversion='2.6'and wfclass.wfclsName like '%Purchase%' and task.tskDisplayName like '%End%' and task.tskName like '%Event%'
















-- Purchase Requisition notifications process

select * from PurchaseEmailsToNotify

select * from wfclass

select * from ENTITY where entity.entName like '%notif%'

select * from mPRNotifications