#!/bin/bash
MY_NAGIOS_HOSTNAME="NAGIOS_HOSTNAME"
MY_FLOCK_ENDPOINT="FLOCK_ENDPOINT"
ENVIRONMENT="Nagios"
color="#FFFF00"
if [ "$NAGIOS_HOSTSTATE" = "UP" ]
then
    state="UP |"
    color="#008000"
elif [ "$NAGIOS_HOSTSTATE" = "DOWN" ]
then
    state="DOWN |"
    color="#FF0000"
else
    state="DEFAULT |"
fi


curl -X POST \
  $MY_FLOCK_ENDPOINT \
  -H 'Content-Type: application/json' \
  -d "{
        \"notification\": \"${state} | $NAGIOS_HOSTNAME\",
   \"sendAs\": {\"name\": \"Nagios Non-Prod\",
        \"profileImage\": \"IMG_URL\"
    },
        \"attachments\": [{
                \"title\": \"${state} host: $NAGIOS_HOSTNAME \",
                
                \"color\": \" ${color} \",
                \"views\": {
                        \"flockml\": \"<flockml> ${state} host : ${NAGIOS_HOSTNAME} <br/>Message: <a href=\\\"http://${MY_NAGIOS_HOSTNAME}/cgi-bin/nagios3/status.cgi?host=${NAGIOS_HOSTNAME} \\\" >${NAGIOS_HOSTOUTPUT}</a> </flockml>\"
                } 
                
                
        }]
}"
