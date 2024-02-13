

select * from TCM_Workshop


select * from TCM_WorkshopType

select * from PurchasesDepartmentEmail





select * from Trainingcoursesmanagemen
select * from TCM_Workshop
select * from TCM_SelectedWorkshop

select * from Trainingcoursesmanagemen where RadNumeber = 'BA2538'
select * from TCM_Workshop where Trainingcoursesmanagemen = 2151
select * from TCM_SelectedWorkshop where TCM_Workshop in (select idTCM_Workshop from TCM_Workshop where Trainingcoursesmanagemen = 2151)


SELECT * FROM TCM_Attendee 

select purchaserequisition.kmProcessData,* from purchaserequisition
SELECT * FROM mprprocessdata