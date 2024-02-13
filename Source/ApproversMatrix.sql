SELECT P.Approvallevel AS "Approval Level", 
WF.fullname AS "Employee", 
WFU.fullName AS "Line Manager", 
CC.CostCentre AS "CC",
CC.CodigoDefinitivo AS "CC Code",
CO.Name AS "Company" 
FROM WFUSER WF, Purchaseapprovallevel P, WFUSER WFU, CC_CostCentre CC, CompanyEU CO 
WHERE WF.idPurchaseapprovallevel = P.idPurchaseapprovallevel 
AND WF.idbossuser = WFU.iduser 
AND WF.enabled = 1 
AND WF.idNewCostCenter = CC.idCC_CostCentre 
AND WF.idCompany = CO.idCompanyEU