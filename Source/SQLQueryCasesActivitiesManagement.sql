select * from WORKITEM
select * from WORKFLOW order by wfcreationdate desc
SELECT * FROM WFCASEUSER
select * from FORM
select * from ENTITY where entName like '%purchase%'

-- Buscar forms en tabla workflow con id y wfversion--------------------------------------------------------------------------------------------------------------------
select idSummaryForm, * from WORKFLOW where  wfVersion=2.5

-- Buscar actividad de cualquier proceso con su respectiva versión-------------------------------------------------------------------------------------------------------

SELECT wfVersion as 'wfVersion', * FROM TASK left join WORKFLOW ON task.idWorkflow=WORKFLOW.idWorkflow 
WHERE tskDisplayName like '%purchase order%'

--vef casos que se van creando en los ambientes --------------------------------------------------------------------------------------------------------------------------
select * from WFCASE

-- ver activities, events, gateways que van pasando en los ambientes-------------------------------------------------------------------------------------------------------
select * from task where tskdisplayname like '%purchase order%'order by idtask desc


--DH: Buscar los casos de una actividad especifica, solo muestra actividades activas ----------------------------------------------------------------------------------------
select 
		wfcase.radnumber as 'Case number',
		wfuser.fullName as 'User assigned',wfuser.iduser as 'User assigned id', wfuser.userName as 'User name',
		wfcase.idcreatoruser as 'Case creator',
		workflow.wfVersion as 'wf Version',task.tskDisplayName,
		workitemstate.wiName as 'State',* 
from 
		workitem right join task on task.idTask=workitem.idTask 
		left join WFCASE on wfcase.idCase=workitem.idCase 
		left join WORKFLOW on task.idWorkflow=WORKFLOW.idWorkflow
		left join WFCASEUSER on wfcase.idCase=WFCASEUSER.idCase
		left join workitemstate on workitem.idworkitemstate=workitemstate.idworkitemstate
		left join WFUSER on wfuser.idUser=wfcaseuser.idUser
WHERE tskDisplayName like '%RFC%' and workitem.wiSolutionDate is null and wfcase.radnumber is not null and workflow.wfversion=1.2
ORDER BY wfcase.radnumber


-- Consulta un caso especifico segun su numero y las actividades o eventos activos en los que se encuentra -------------------------------------------------------------------
select 
		wfcase.radnumber as 'Case number',
		wfuser.fullName as 'User assigned',wfuser.iduser as 'User assigned id', wfuser.userName as 'User name',
		wfcase.idcreatoruser as 'Case creator',
		workflow.wfVersion as 'wf Version',task.tskDisplayName,
		workitemstate.wiName as 'State',* 
from 
		workitem right join task on task.idTask=workitem.idTask 
		left join WFCASE on wfcase.idCase=workitem.idCase 
		left join WORKFLOW on task.idWorkflow=WORKFLOW.idWorkflow
		left join WFCASEUSER on wfcase.idCase=WFCASEUSER.idCase
		left join workitemstate on workitem.idworkitemstate=workitemstate.idworkitemstate
		left join WFUSER on wfuser.idUser=wfcaseuser.idUser
WHERE  wfcase.radnumber = 'US-121358' --is not null



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Busca los casos que han sido abortados junto con las razones para cancelarlos administrativamente
SELECT * FROM WFCASEABORTREASON

SELECT radNumber as 'Case num',abortReason as 'Abort reasons', * 
from WFCASE join WFCASEABORTREASON on wfcase.idCase=WFCASEABORTREASON.idCase where abortReason like '%cancelled%'
order by WFCASE.idCase desc 


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------