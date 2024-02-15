
variable "data_center" {
   default = "IPV6-HYB"
}
variable "cluster"                  {
  default = "Sea-c01"
}
variable "workload_datastore"       {
   default = "pure-ds01"
}
variable "user"                     {
   default = "aleksandr.karmazin@ipv630-hyb-vsphere.local"
}
variable "password"                 {
   default = "Tol3r8t3now!"
}
variable "vsphere_server"           {
   default = "10.196.123.11"
}
variable "vmname"                   {
   default = "domain-test"
}

variable "join_domain"              {
   default = "exchangelab.local"
}
variable "domain_admin_user"        {
  default = "itom.disco@exchangelab.local"
}
variable "domain_admin_password"    {
   default = "Tol3r8t3now!"
}

variable "installation_commands" {
   description = "Commands to install the application"
   type = list(string)
   default = [
      "powershell.exe Write-Output 'SQL Server 2022 Installation'",
      "powershell.exe Invoke-WebRequest https://go.microsoft.com/fwlink/p/?linkid=2215158 -OutFile 'C:\\SQLServerDeveloperEdition2022.exe'",
      "powershell.exe Start-Process -FilePath 'C:\\SQLServerDeveloperEdetion2022.exe' -ArgumentList '/Q /IACCEPTSQLSERVERLICENSETERMS' -Wait",
      "powershell.exe Write-Output 'SQL Server 2022 Installation Completed'"]
}

