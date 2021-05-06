#percorso file host
hosts="./param/host.txt"

#variabile timeout ping tentativi
timeout=3

#variabile min host down
hostdown=3

#variabile min host online
hostonline=1

#parametri log
file_log="./log/log.txt"
log_fail=1

#marametri invio mail
sendmail=1
email="./param/email.txt"
template="./template"

#percorso file output verifica esecuzione del programma
checkprogram="./param/checkprogram.txt"
lasttimestamp=$(head -n 1 $checkprogram)

#variabile timeout reset programma
resetprogram=60
