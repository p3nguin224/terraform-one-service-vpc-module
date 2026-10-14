This is test for creating a custom module.

This build a single vpc with a Web-App running inside private subnet.

Input:
1. VPC Name 
2. VPC CIDR range
3. List of string for Public Subnet range
4. List os string for Private Subnet range
5. Security Group for web application server
6. Relative Path to User Data file from current module. It will be used on web application server

7. Instance_Name
8. Instance_Type
9. Key_name
10. User data file name

11. create_Bastion (boolean)
12. listenPort