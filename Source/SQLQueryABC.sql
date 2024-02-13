




SELECT pARSSubscriptions.kpInvoiceSection,* FROM mABCBudgetDetails left join pARSSubscriptions on pARSSubscriptions.idpARSSubscriptions=mABCBudgetDetailS.kpSubscription 
WHERE pARSSubscriptions.kpInvoiceSection LIKE '%12%'


select * from pARSSubscriptions 
select * from pARSOwners left join WFUSER on wfuser.idUser=pARSOwners.ksResponsible where wfUser.fullName like '%Daniel%'
select * from pARSInvoiceSection


select * from mABCBudgetInfo


--Process Entity
select * from mABC

select * from ABCBudgetTypeCaseC




BEGIN --ABC Process entity global cases information
		
		SELECT 
			pARSSubscriptions.sIdSubscription,
			pABCBudgetType.sBudgetName,
			pARSSubscriptions.sName,
			mABC.sCaseNumber,
			pABCFiscalYear.sName,
			pABCTimeGrain.sName,
			mABCBudgetInfo.dStartDate, 
			mABCBudgetInfo.dEndDate,
			pABCQuarter.sName,
			mABCBudgetDetails.sAzureErrorMessage,
			mABCBudgetDetails.iAPIStatusCode,
			*
		FROM 
			mABCBudgetDetails 
			left join mABCBudgetInfo on mABCBudgetDetails.mABCBudgetInfo=mABCBudgetInfo.idmABCBudgetInfo
			left join mABC on mABC.idmABC=mABCBudgetInfo.kmABC
			left join pARSSubscriptions on mABCBudgetDetails.kpSubscription=pARSSubscriptions.idpARSSubscriptions
			left join pABCQuarter ON pABCQuarter.idpABCQuarter=mABCBudgetInfo.kpQuarter
			LEFT JOIN pABCFiscalYear on pABCFiscalYear.idpABCFiscalYear=mABCBudgetInfo.kpFiscalYear
			left join pABCTimeGrain ON pABCTimeGrain.idpABCTimeGrain=mABCBudgetInfo.kpTimeGrain
			left join pABCBudgetType ON pABCBudgetType.idpABCBudgetType=mABC.kpBudgetType
		--WHERE
			--pARSSubscriptions.sIdSubscription like '%479caa59-8389-419d-a6b1-ccb9716c78e9%'
		
		
		--ORDER BY
			--mABC.dCaseCreationDate DESC
END



select * from pABCBudgetType
select * from pabcfiltersbdgttype
select * from pabcfiltervalues

select * from mABCBudgetDetails left join pARSSubscriptions on pARSSubscriptions.idpARSSubscriptions= mABCBudgetDetails.kpSubscription 
where pARSSubscriptions.idpARSSubscriptions like'%2976ce0a-5958-43f4-90d9-bffece1bdce5%'


--'%2976ce0a-5958-43f4-90d9-bffece1bdce5%','%24fb3ffb-d168-4b1b-a2fc-c0da61cd67c5%')




select * from mABCGraphicAnalysis

select * from mABCBudgetXMG

SELECT * FROM mABCBudgetXIS order by mABCBudgetXIS.idmABCBudgetXIS desc


select * from wfclass where wfClsDisplayName like '%ABC%'

select * from ABCBudgetTypeCaseC




BEGIN

UPDATE mABCBudgetDetails 

SET mABCBudgetDetails.bInactiveBudgetSubs='true'

FROM
			mABCBudgetDetails 
			left join mABCBudgetInfo on mABCBudgetDetails.mABCBudgetInfo=mABCBudgetInfo.idmABCBudgetInfo
			left join mABC on mABC.idmABC=mABCBudgetInfo.kmABC
WHERE mABC.sCaseNumber IN('ABC1','ABC2','ABC3','ABC4','ABC5','ABC6')


END

select bInactiveBudgetSubs, * from mABCBudgetDetails
