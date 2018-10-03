#!/bin/bash

MY_NAGIOS_HOSTNAME="NAGIOS_HOSTNAME"
MY_FLOCK_ENDPOINT="FLOCK_ENDPOINT"
ENVIRONMENT="Nagios"
color="#FFFF00"

if [ "$NAGIOS_SERVICESTATE" = "CRITICAL" ]
then
    state="CRITICAL |"
    color="#FF0000"
elif [ "$NAGIOS_SERVICESTATE" = "WARNING" ]
then
    state="WARNING |"
    color="#FFFF00"
elif [ "$NAGIOS_SERVICESTATE" = "OK" ]
then
    state="OK |"
    color="#008000"
elif [ "$NAGIOS_SERVICESTATE" = "UNKNOWN" ]
then
    state="UNKNOWN |"
else
    state="DEFAULT |"
fi


curl -X POST \
  $MY_FLOCK_ENDPOINT \
  -H 'Content-Type: application/json' \
  -d "{
        \"notification\": \"${state} | $NAGIOS_SERVICEOUTPUT\",
   \"sendAs\": {\"name\": \"Nagios Non-Prod\",
        \"profileImage\": \"IMG_URL\"
    },
        \"attachments\": [{
                \"title\": \" ${state} service: ${NAGIOS_SERVICEDISPLAYNAME} \",
                
                \"color\": \" ${color} \",
                \"views\": {
                        \"flockml\": \"<flockml> ${state} service: ${NAGIOS_SERVICEDISPLAYNAME} <br/> Host: ${NAGIOS_HOSTNAME}  <br/>Message: <a href=\\\"http://${MY_NAGIOS_HOSTNAME}/cgi-bin/nagios3/status.cgi?host=${NAGIOS_HOSTNAME} \\\" >${NAGIOS_SERVICEOUTPUT}</a> </flockml>\"
                } 
                
                
        }]
}"
