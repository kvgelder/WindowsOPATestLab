# Microsoft Endpoint Configuration Manager (MECM)
## Configuration
### Device enrollment
By default MECM will check for domain joined devices ever 60 minutes. If new devices have been discovered, they will be enrolled into MECM Mobile Device Management (MDM).

This interval can be modified via the Administration/Client Settings/Default Client Settings/Enrollment option page.

### Installing the MECM client using the Push Installation option
In order to push the client installation to a target device, a few things will need to be verified.  
  
1. First make sure the Client Push Installation account in MECM is a member of the Local Administrators group on the client computer.
2. The site server needs to be able to resolve the target computer name.
3. The site server needs to be able to access the ADMIN$ share on the target computer.
4. The firewall on the target computer needs to be configured to allow communication between the site computer and the target computer.
5. The management point is operational.