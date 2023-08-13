$Port = 2701

Get-NetFirewallPortFilter | Where-Object { $_.LocalPort -eq $Port } | Get-NetFirewallRule | Select-Object DisplayName,Direction,Action,Enabled | Format-Table -Wrap -AutoSize