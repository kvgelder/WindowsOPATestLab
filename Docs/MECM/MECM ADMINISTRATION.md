# Microsoft Endpoint Configuration Manager (MECM)
## Configuration
### Device enrollment
By default MECM will check for domain joined devices ever 60 minutes. If new devices have been discovered, they will be enrolled into MECM Mobile Device Management (MDM).

This interval can be modified via the Administration/Client Settings/Default Client Settings/Enrollment option page.

### Installing the MECM client using the Push Installation option
In order to push the client installation to a target device, a few things will need to be verified.  
  
1. First make sure the Client Push Installation account in MECM is a member of the Local Administrators group on the client computer.
This can be taken care of manually or via a GPO. First create a new Active Directory Group, to which you add the correct Active Directory users.
Then open the Group Policy editor (or use PowerShell) to create the following GPO: `Computer/Preferences/Control Panel Settings/Local Users and Groups/`. Here you can add the newly created Active Directory group.
Set the action to `Update`. Change the group name to `Administrators (built-in)`. Add the previously created Active Directory security group to the `Members` list.  

2. The site server needs to be able to resolve the target computer name.  

3. The site server needs to be able to access the ADMIN$ share on the target computer.  

4. The firewall on the target computer needs to be configured to allow communication between the site computer and the target computer.  

5. The management point is operational.