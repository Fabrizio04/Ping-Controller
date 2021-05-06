# imposto i parametri che compongono le mail
destinatari=""
oggetto=""
messaggio=""
datamail=""

for ind in $(cat $email); do
  if [[ "$destinatari" == "" ]]; then
    destinatari="$ind"
  else
    destinatari+=" $ind"
  fi
done

function sendMail() {
  echo "$2" | mailx -a 'Content-Type: text/html' -s "$1" $destinatari
}

# funzione avviso Check Ping x Host Offline
function sendMailOffline() {
  if [[ "$sendmail" != "0" ]]; then
    datamail="$(date '+%d/%m/%Y %H:%M:%S')"
    oggetto="Ping Controller - Host Offline ($datamail)"
    body="$template/sendMailOffline.sh"
    formatHtml
    source $body
    sendMail "$oggetto" "$messaggio"
  fi

}

# funzione avviso se persiste problema dopo verifica
function sendMailPost() {
  if [[ "$sendmail" != "0" ]]; then
    datamail="$(date '+%d/%m/%Y %H:%M:%S')"
    oggetto="Ping Controller - Persiste Problema ($datamail)"
    body="$template/sendMailPost.sh"
    formatHtml
    source $body
    sendMail "$oggetto" "$messaggio"
  fi

}

# funzione che invia la mail se dopo i 2 controlli precedenti, il problema del ping ancora persiste
function sendMailPersists() {
  if [[ "$sendmail" != "0" ]]; then
    datamail="$(date '+%d/%m/%Y %H:%M:%S')"
    oggetto="Ping Controller - Persiste Problema ($datamail)"
    body="$template/sendMailPersists.sh"
    formatHtml
    timestamp=$((timestamp / 60))
    source $body
    sendMail "$oggetto" "$messaggio"
  fi

}
