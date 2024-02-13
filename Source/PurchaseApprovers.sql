SELECT WF.idUser AS 'EID',
WF.fullname AS 'Employee Name',
LVL.Approvallevel AS 'Approval Level',
JT.Name AS 'Working Job Title',
JTI.Name AS 'Bizagi Job Title',
BG.Name AS 'Bizagi Job Title Grade',
WF2.fullName AS 'Manager'
FROM WFUSER WF
LEFT JOIN Purchaseapprovallevel LVL ON WF.idPurchaseapprovallevel = LVL.idPurchaseapprovallevel
LEFT JOIN JobTittle JT ON WF.idJobTitle = JT.idJobTittle
LEFT JOIN HR_InternalJobTitle JTI ON WF.idInternalJobTitle = JTI.idHR_InternalJobTitle
LEFT JOIN HR_BizagiGrade BG ON JTI.BizagiGrade = BG.idHR_BizagiGrade
LEFT JOIN WFUSER WF2 ON WF.idBossUser = WF2.idUser
WHERE WF.enabled = 1 AND WF.idUser != 1
ORDER BY WF.fullName