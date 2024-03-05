select * from WFUSER where userName=''
select * from WFUSER where idUser='156460'
select * from WFUSER where userName like '% insert user name here%' 
select * from WFUSER where fullName like '%Daniela%' 
select * from CentroDeCostosPorRegion
select * from CostCenterEU
select * from RelatedLocation

select * from WFUSER where contactEmail like '%andres.gonzalez@bizagi.com%'
select * from wfuser where iduser=152578

-- Consulta los usuarios y sus jefes asignados ----------------------------------------------------------------------------------------------

select users.enabled,users.userName,wfBoss.userName as BossUser,* 
from wfuser users left join wfuser wfBoss on users.idBossUser=wfBoss.idUser 
--where users.username like '%annap%'
--where users.contactEmail  like '%dl-productivity%'
where users.enabled=1 and wfBoss.fullname like '%stephan%' --and users.userName = wfBoss.userName


---------------------------------------------------------------------------------------------------------------------------------------------

select * from USERROLE
select * from ORGPOSITION where posName like '%cloud%'
select * from skill where skilldisplayname like '%purchase%'
select * from USERSKILL
select * from ROLE where roleName like '%ITBO%'
select * from jobtittle where Name like '%analyst%'






-- Busca los roles y niveles de aprobación PR (con montos max.) que tiene asignado un usuario -----------------------------------------------
select
		userName,wfuser.fullname,wfuser.idPurchaseapprovallevel,Purchaseapprovallevel.Code ,
		purchaseapprovalranges.maxamount,* 
from 
		ROLE join USERROLE ON ROLE.idRole=USERROLE.idRole 
		join WFUSER ON WFUSER.idUSER=USERROLE.idUser
		left join Purchaseapprovallevel on Purchaseapprovallevel.idPurchaseapprovallevel=wfuser.idPurchaseapprovallevel
		left join purchaseapprovalranges on purchaseapprovalranges.purchaseapprovallevel=purchaseapprovallevel.idPurchaseapprovallevel
where wfuser.fullname like '%Blanco%' 



-- Busca los usuarios con cierto rol ------------------------------------------------------------
select userName,fullname,* 
from ROLE left join USERROLE ON ROLE.idRole=USERROLE.idRole 
left join WFUSER ON WFUSER.idUSER=USERROLE.idUser 
where roleDisplaynAME like '%accounting%' and WFUSER.enabled=1


-- Busca los usuarios con cierto job tittle
select userName,fullname,Name,* from WFUSER
 left join JobTittle on WFUSER.idJobTitle=jobtittle.idJobTittle 
where Name like '%cloud administrator%' 
--where WFUSER.ENABLED=1 and Name like '%cloud administrator%' 


--Searched users with certain skill

select wfuser.userName, wfuser.fullName,skill.skillName, * 
from wfuser left join USERSKILL on USERSKILL.idUser=wfuser.idUser
left join SKILL on skill.idSkill=USERSKILL.idSkill 
where skill.skillName like '%cloudAdmin%'
--where wfuser.enabled=1 and skill.skillName like '%cloudAdmin%'
