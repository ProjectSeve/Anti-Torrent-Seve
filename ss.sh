# Get Pid
pid=$!
# Start Pass
PASS="sevescripts"
read -s -p "Password: " mypassword
echo ""
if [ "$mypassword" == "$PASS" ] 
then 
   echo "Password accepted"
else 
   exit 1
fi
echo "Welcome HELLO"
