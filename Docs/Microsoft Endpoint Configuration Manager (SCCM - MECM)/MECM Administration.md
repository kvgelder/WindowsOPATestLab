# Microsoft Endpoint Configuration Manager (MECM)
## Configuration
### Device enrollment
By default MECM will check for domain joined devices ever 60 minutes. If new devices have been discovered, they will be enrolled into MECM Mobile Device Management (MDM).

This interval can be modified via the Administration/Client Settings/Default Client Settings/Enrollment option page.

### Installing the MECM client using the Push Installation option
In order to push the client installation to a target device, a few things will need to be verified and configured.  

#### 1. Local Administrator  
In order to deploy the client agent via the Client Push Installation, we need to make sure this account in MECM is a member of the Local Administrators group on the client computer.
If this is not the case, one of the ways we can do this is via GPO.

First create a new Active Directory Group, to which you add the Active Directory users that need have the Local Administrator permissions.  
Now open the Group Policy editor to create the following GPO: `Computer/Preferences/Control Panel Settings/Local Users and Groups/`. Here you can add the newly created Active Directory group.  
Set the action to `Update`. Change the group name to `Administrators (built-in)`. Add the previously created Active Directory security group to the `Members` list.  

You can create the GPO via PowerShell as follows:

First we need to prepare the XML file which will contain the GPO configuration settings.
Create a file name LocalAdministratorGPO.xml, in the root directory of your C:\ drive.
Edit the XML file and add the following contents.
```XML
<?xml version="1.0"?>
<Group>
    <UserAction>add</UserAction>
    <GroupName>Administrators</GroupName>
    <Members>
        <Member> 
            <Name>[NAME OF YOUR SECURITY GROUP]</Name>
        </Member>
    </Members>
</Group>
```

Now we can create the GPO via PowerShell as follows
```PowerShell
$GPOName = 'Local Admins GPO'
$OU = 'OU=Computers,DC=example,DC=com'
$GPOSettingsXMLFile = 'C:\LocalAdministratorGPO.xml'

$GPO = New-GPO -Name $GPOName
New-GPLink =Name $GPOName -Target $OU
Import-GPO -Path $GPOSettingsXMLFile -GPO $GPO
```

This will create the GPO, link it to the correct OU. And import the settings into the GPO we just created.


#### 2. The site server needs to be able to resolve the target computer name.  

#### 3. The site server needs to be able to access the ADMIN$ share on the target computer.  

#### 4. The firewall on the target computer needs to be configured to allow communication between the site computer and the target computer.  
The following general ports are recommended to be opened on the MECM client target devices.

- **TCP 135**: Used for Remote Procedure Calls (RPC)
- **TCP 2701-2702**: Used for the Background Intelligent Transfer Service (BITS)
- **TCP 2703**: Used for the CCMExec service which manages the main client agent functionality
- **TCP 49152-65535**: A dynamic port range used for various communication
- **TCP 69**: Used for PXE deployments
    - **UDP 69**: Used for TFTP communication during the PXE boot process
- **TCP 4011**: Used for Wake On LAN (WoL) communication
- **TCP 10123**: BGB Client connectivity and SMS Notification Client Communication

```PowerShell
# Inbound rules
New-NetFirewallRule -DisplayName "MECM Client Agent - RPC" -Direction Inbound -LocalPort 135 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - BITS" -Direction Inbound -LocalPort 2701,2702 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - CCMExec" -Direction Inbound -LocalPort 2703 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - WoL" -Direction Inbound -LocalPort 4011 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - Ephemeral Communication" -Direction Inbound -LocalPort 49152-65535 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - BGB Client and SMS Notification Client Communication" -Direction Inbound -LocalPort 10123 -Protocol TCP -Action Allow -Profile Domain

# Outbound rules
New-NetFirewallRule -DisplayName "MECM Client Agent - RPC" -Direction Outbound -LocalPort 135 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - BITS" -Direction Outbound -LocalPort 2701,2702 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - CCMExec" -Direction Outbound -LocalPort 2703 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - WoL" -Direction Outbound -LocalPort 4011 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - Ephemeral Communication" -Direction Outbound -LocalPort 49152-65535 -Protocol TCP -Action Allow -Profile Domain

New-NetFirewallRule -DisplayName "MECM Client Agent - BGB Client and SMS Notification Client Communication" -Direction Outbound -LocalPort 10123 -Protocol TCP -Action Allow -Profile Domain
```

# TODO: GPO walkthrough

#### 5. The management point is operational.


### Client enrollment and connectivity issues
#### 1. Client prerequisites

#### 2. Client Agent installation 

#### 3. Client Agent health avaluation scheduled task

#### 4. Verify the Windows Management Instrumentation on the client device

#### 5. Verify the policy platform
Microsoft Policy Platform Processer
Microsoft Policy Platform Local Authority

#### 6. Verify the BITS service
Background Intelligent Transfer Service

#### 7. Verify remote control