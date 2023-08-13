#

## Configuring distribution points for PXE

## Prepare a PXE-enabled boot image

## Duplicate hardware identifiers
In case multiple computers have the same SMBIOS attributes, or when they use a shared network adapter, MECM might recognize these computers as a single device.

## Firewall rules
```PowerShell
# Inbound rules
New-NetFirewallRule -DisplayName "MECM Client Agent - PXE" -Direction Inbound -LocalPort 69 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - TFTP for PXE" -Direction Outbound -LocalPort 67,68,69,4011 -Protocol UDP -Action Allow -Profile Domain

# Outbound rules
New-NetFirewallRule -DisplayName "MECM Client Agent - PXE" -Direction Outbound -LocalPort 69 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - TFTP for PXE" -Direction Outbound -LocalPort 67,68,69,4011 -Protocol UDP -Action Allow -Profile Domain
```

### Exclusion list for PXE deployments
