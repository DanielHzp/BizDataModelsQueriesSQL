


-- Tabla customer

select * from mCustomer
select * from pCustomerType

select mCustomer.sCompanyName,mCustomerCaseHistory.sStatus,* from mCustomer left join mCustomerCaseHistory on mCustomerCaseHistory.mCustomer=mCustomer.idmCustomer
where mCustomerCaseHistory.sStatus LIKE'%O%'

--mCOFProduct.dOffboardDate as OffboardingDate
--count(distinct mCustomer.sCompanyName)
select mCustomerCaseHistory.sCaseNumber AS caseFromCaseHistory,mCustomerCaseHistory.dDate as DateCaseHistory,* from mCustomer left join mCustomerProduct on mCustomerProduct.mCustomer3 = mCustomer.idmCustomer
--left join mCOFProduct on mCOFProduct.kmCustomerProduct=mCustomerProduct.mCustomer3
left join mCustomerCaseHistory on mCustomerCaseHistory.mCustomer=mCustomer.idmCustomer
where mCustomerCaseHistory.sCaseNumber is not null and mCustomerCaseHistory.sCaseNumber LIKE '%COF%' and mCustomerCaseHistory.dDate between '2022-04-01' and '2023-03-31' 
--GROUP BY mCustomer.sCompanyName


select count(*), mCustomer.sCompanyName, mCustomerCaseHistory.sCaseNumber AS caseFromCaseHistory, mCustomerCaseHistory.sStatus,mCustomerCaseHistory.dDate as DateCaseHistory from mCustomer left join mCustomerProduct on mCustomerProduct.mCustomer3 = mCustomer.idmCustomer
--left join mCOFProduct on mCOFProduct.kmCustomerProduct=mCustomerProduct.mCustomer3
left join mCustomerCaseHistory on mCustomerCaseHistory.mCustomer=mCustomer.idmCustomer
where mCustomerCaseHistory.sCaseNumber is not null and mCustomerCaseHistory.sCaseNumber LIKE '%COF%' and mCustomerCaseHistory.dDate between '2022-04-01' and '2023-03-31' 
group by mCustomerCaseHistory.sStatus, mCustomer.sCompanyName, mCustomerCaseHistory.dDate, mCustomerCaseHistory.sCaseNumber
having count(*) > 1 order by mCustomerCaseHistory.sCaseNumber


select c.sCompanyName, c.dCreationDate, c.kpCustomerType, cp.sCaseOffboarding, cp.dEndDate, cp.kpProductOnboardStatus, cch.sCaseNumber, cch.sStatus
from mcustomer as c join mCustomerProduct as cp on c.idmCustomer = cp.mCustomer  join mCustomerCaseHistory as cch on c.idmCustomer = cch.idmCustomerCaseHistory
WHERE cp.sCaseOffboarding is not null

-- Tablas customer products
select * from mCustomerProduct
select * from pProductOnboardStatus
select pProductOnboardStatus.sDescription as Status,* from mCustomerProduct left join pProductOnboardStatus on mCustomerProduct.kpProductOnboardStatus=pProductOnboardStatus.idpProductOnboardStatus


--Tablas onboarding history
select * from mCustomerCaseHistory where mCustomerCaseHistory.kmCOF is not null


-- Tablas offboarding history
select * from mCOF
SELECT * FROM mCOFProduct


select * from WFCASE





