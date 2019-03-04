<#
------------------------------------------------------------
Author: John Leger
Date: February 27, 2017
Powershell Version Built/Tested on: 5.1
Title: Create New AD Groups from CSV file
Website: https://github.com/johnbljr
License: GNU General Public License v3.0
------------------------------------------------------------
#>   

## Must be run as Domain Admin

$csv = Import-Csv c:\temp\NewEUGroups.csv
foreach ($item in $csv)
{
  New-ADGroup -Name $item.GroupName -GroupScope $item.GroupScope -Path $item.GroupLocation -Description $item.Description -GroupCategory $item.GroupCategory
#Verify Creation and output to file
  Get-ADGroup -identity $item.GroupName -Properties * | select-object SamaccountName,GroupCategory,GroupScope,Name | Export-csv c:\temp\groupcreationresults.csv -Append -NoTypeInformation
 }

<#
CSV File Format
GroupName,GroupScope,GroupLocation,Description,GroupCategory
GroupName,Universal,"OU=AccessGroups,DC=domain,DC=local",Group Description,Security

Options for Group Scope {DomainLocal | Global | Universal} 
Options for Group Category {Distribution | Security}
#>