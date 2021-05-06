# richiamo gli script dei parametri e delle funzioni
source ./include/param.sh
source ./include/functions.sh
source ./include/email.sh

# Inizio Programma

#clear
echo "=== Ping Checker [FULL] ==="
echo
echo "Timeout ping vs host impostato: $timeout"
echo "MIN host down impostato: $hostdown"
echo "MIN host online impostato: $hostonline"
echo

# eseguo il primo controllo
doCheckPing

#controllo full (countfail >= hostdown)
if [ $countfail -ge $hostdown ]; then

  if [ $countok -ge $hostonline ] && [ $hostonline -ne 0 ]; then
    echo "0" >$checkprogram
    echo "Nessun problema riscontrato"
    exit
  fi

  #verifico lo stato del programma
  checkProgram

  sleep 5

  #inviare mail di avviso
  sendMailOffline

  #personalizzare funzione verifica (functions.sh)
  verifyCheck

  sleep 5
  echo
  echo "Controllo nuovamente gli host..."
  echo
  doCheckPing

  if [ $countfail -ge $hostdown ]; then

    if [ $countok -ge $hostonline ] && [ $hostonline -ne 0 ]; then
      echo "0" >$checkprogram
      echo "Nessun problema riscontrato"
      exit
    fi

    #problema persiste inviare mail di avviso
    sendMailPost

    newtimestamp=$(date +%s)
    echo "$newtimestamp" >$checkprogram

    writeLogFail "Persiste problema dopo prima verifica"

  else
    echo "0" >$checkprogram
    echo "Problema risolto"
  fi

else

  echo "0" >$checkprogram
  echo "Nessun problema riscontrato"
fi

echo
echo "=== Fine ==="
echo
