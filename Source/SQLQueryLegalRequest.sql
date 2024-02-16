


select * from LegalRequestType

select * from Partenragreementtype

--Search all cases transactional info of Legal request process
select LegalRequestType.Description,contractmanagement.NumeroCaso ,* from contractmanagement left join LegalRequestType on LegalRequestType.idLegalRequestType=ContractManagement.LegalRequestType
where LegalRequestType.Description like '%Reseller%'

--Search NDA Contract Mng relevant attributes in legal request process
select CRMREQUEST,EndDateReviewing,GeneralCounselValidation,LegalValidationComments,HoursReviewing,EndDateReviewing,
NewContractVersionComments,Uploadnewversion,LegalCouncelValidationComm,NeedApprovalAfterLCreview,LegalCounselValidation,NewContractVersion,
approvalPhaseFlag,*
from ContractManagement where NumeroCaso='CO-133072'

select * from LegalCounselValidation

select NumeroCaso,* from ContractManagement



select * from cliente


select * from Partenragreementtype




select * from reseller_ApproverPositio

select * from ORGPOSITION

select * from reseller_ApproverPositio





select * from CM_ContractGroup