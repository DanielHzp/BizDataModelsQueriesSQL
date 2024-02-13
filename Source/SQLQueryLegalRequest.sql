


select * from LegalRequestType

select * from Partenragreementtype

--Search all cases transactional info of Legal request process
select LegalRequestType.Description,contractmanagement.NumeroCaso ,* from contractmanagement left join LegalRequestType on LegalRequestType.idLegalRequestType=ContractManagement.LegalRequestType
where LegalRequestType.Description like '%Reseller%'


select * from cliente


select * from Partenragreementtype




select * from reseller_ApproverPositio

select * from ORGPOSITION

select * from reseller_ApproverPositio