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
   kill -9 $pid
fi
sleep 2
clear
