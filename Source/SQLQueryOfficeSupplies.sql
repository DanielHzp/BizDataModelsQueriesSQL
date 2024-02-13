-- Consulta los items pedidos en el proceso office supplies
select Requestdate as 'Request date',officesupplies.CaseNumber,AssetName as 'Item requested', wfuser.fullName as 'Case creator',ConfirmDelivery,* 
from 
	OfficeSupplies right join OfficeSuppliesAssets on officesupplies.idOfficeSupplies=OfficeSuppliesAssets.OfficeSupplies 
	right join assetlist on assetlist.idAssetList=OfficeSuppliesAssets.AssetList
	left join wfuser on wfuser.idUser=officesupplies.casecreator
where officesupplies.CaseNumber LIKE '%CO-122406%'
order by 
	requestdate desc