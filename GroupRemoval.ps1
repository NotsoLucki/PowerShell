#This PS script will remove GroupName from UserName and ComputerName$. 
#To add more than one user or computer, use a comma. 
#Computers need a $ at the end of it. 
#The -whatif is used to see if the script will work; remove it to run the script.
#Source: https://blog.netwrix.com/2018/06/19/how-to-add-and-remove-ad-groups-and-objects-in-groups-with-powershell/#Removing%20Users%20or%20Computers%20from%20a%20Group

Remove-ADGroupMember -Identity GroupName -Members UserName, ComputerName$ -whatif
