#This PS script will remove GroupName from UserName and ComputerName$. 
#To add more than one user or computer, use a comma. 
#Computers need a $ at the end of it. 
#The -whatif is used to see if the script will work; remove it to run the script.

Remove-ADGroupMember -Identity GroupName -Members UserName, ComputerName$ -whatif
