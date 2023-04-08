To use the development volumes and have the cloned repos easily available,
create folders named `odoo` and `repos` inside this `opt` folder, they will
have the code that docker will be using.

Caveat: Your linux UID must be 1001 or some tweaking might be needed. 

If you need to start from a fresh code copy, removing the folders is not
enough, you'll need to remove the code volume and run compose again. 
