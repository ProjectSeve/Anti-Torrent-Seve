# Get Pid
PID=$!
# Start Pass
PASS="sevescripts"
read -s -p "Password: " mypassword
echo ""
if [ "$mypassword" == "$PASS" ] 
then 
   echo "Password accepted"
else 
   kill -INT ${PID}
fi
sleep 2
clear
