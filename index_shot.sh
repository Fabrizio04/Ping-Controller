# richiamo gli script dei parametri e delle funzioni
source ./include/param.sh
source ./include/functions.sh
source ./include/email.sh

# Inizio Programma

#clear
echo "=== Ping Checker [SHOT] ==="
echo
echo "Timeout ping vs host impostato: $timeout"
echo "MAX host down impostato: $hostdown"
echo

# eseguo il primo controllo
doCheckPingShot

#controllo shot (countfail = hostdown)
if [ $countfail -eq $hostdown ]; then

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
  doCheckPingShot

  if [ $countfail -eq $hostdown ]; then

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
