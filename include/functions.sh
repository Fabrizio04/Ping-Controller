#funzione log
function writeLogFail() {
  if [[ "$log_fail" != "0" ]]; then
    datalog=""
    datalog="$(date '+%d/%m/%Y %H:%M:%S')"
    echo "$datalog - $1" >>$file_log
  fi
}

#funzione che formatta gli host per la mail
function formatHtml() {
  start=0
  br="<br>"
  end=$((hostdown - 1))

  html="${failed_hosts/[-]/$br}"

  while [ $start -lt $end ]; do
    html="${html/[-]/$br}"
    let start=start+1
  done

}

#funzione ping vs host FULL
function doCheckPing() {
  countfail=0
  countok=0
  failed_hosts=""

  for i in $(cat $hosts); do
    echo "Ping VS Host: $i"
    ping -w $timeout -c $timeout $i &>/dev/null

    if [ $? -ne 0 ]; then
      countfail=$((countfail + 1))

      if [[ "$failed_hosts" == "" ]]; then
        failed_hosts="$i"
      else
        failed_hosts+=" - $i"
      fi

      echo "fallito"
      echo
    else
      echo "ok"
      echo
      countok=$((countok + 1))
    fi
  done

}

#funzione ping vs host SHOT
function doCheckPingShot() {
  countfail=0
  failed_hosts=""

  for i in $(cat $hosts); do
    echo "Ping VS Host: $i"
    ping -w $timeout -c $timeout $i &>/dev/null

    if [ $? -ne 0 ]; then
      countfail=$((countfail + 1))

      if [[ "$failed_hosts" == "" ]]; then
        failed_hosts="$i"
      else
        failed_hosts+=" - $i"
      fi

      echo "fallito"
      echo

      if [ $countfail -eq $hostdown ]; then
        break
      fi

    else
      echo "ok"
      echo
    fi
  done

}

#function controllo stato programma
function checkProgram() {

  timestamp=$(date +%s)

  if [[ "$lasttimestamp" != "0" ]]; then
    timestamp=$((timestamp - lasttimestamp))
    #echo "$timestamp"

    if [ $timestamp -ge $resetprogram ]; then
      #echo "SONO passati più di $resetprogram secondi"
      sendMailPersists
      echo "0" >$checkprogram
    else
      #echo "NON sono passati più di $resetprogram secondi"
      sendMailPersists
    fi

    exit

  fi

}

#function personalizzata per effettuare una prima verifica vs host offline
function verifyCheck() {
  writeLogFail "verifyCheck()"
}
