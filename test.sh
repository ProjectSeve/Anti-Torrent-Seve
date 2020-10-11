PASS="sevescripts"
read -s -p "Password: " mypassword
echo ""
if [ "$mypassword" == "$PASS" ] 
then 
   echo "Password accepted"
else 
   echo "Access denied" && exit
fi
echo "WELCOME TO SEVE SCRIPTS"
