# Ping-Controller
## Ping-Controller è un piccolo sistema scritto in Shell puro molto semplice per effettuare una veridica periodica attraverso un Ping su una lista di Host, con avviso e-mail in caso di irraggiungibilità.
<br>

### Componenti richiesti (per avviso via mail)

- Mailx (Es. postfix)

Questa funzione in ogni caso può essere disattivata
<br><br>
### Manuale

Percorso launcher programma:

```bash
%path%/launch.sh
```

Questo è lo script da puntare per lanciare il programma, anche ad esempio con crontab.<br>
In quest'ultimo è possibile specificare il tipo di controllo.<br>
I parametri per specificare la tipologia di monitoraggio sono:

```bash
full = il monitoraggio controlla tutti gli indirizzi e verifica n. hostdown e hostonline impostati
shot = il monitoraggio termina appena vengono contati n. hostdown impostati
```
<br><br>
Percorso script parametri programma:

```bash
%path%/include/param.sh
```

Di seguito la lista completa dei parametri

```bash
hosts = "STRING (path)"
        percorso (relativo o assoluto) del file degli host
        gli host vanno inseriti nel file uno per ogni riga
		
timeout = INT (sec)
          timeout ping tentativi (sia per risposta, sia per fail)

hostdown = INT
           FULL = numero minimo verifica host non raggiungibili
           SHOT = numero massimo verifica host non raggiungibili

hostonline = INT
           0  - verifica host online disattivata
           >0 - numero minimo verifica host raggiungibili
           questo controllo è disponobile solo per il monitoraggio FULL

file_log = "STRING (path)"
           percorso (relativo o assoluto) del file log eventi

log_fail = INT (0-1)
           1 - log attivato
           0 - log disattivato

template = percorso (relativo o assoluto) dei template delle varie mail
           all'interno del file di template bisogna creare una variabile
           messaggio = "STRING"
           i vari script dei template ereditano le variabili disponibili
           le variabili possono essere inserire nel body del messaggio
		   
sendmail = INT (0-1)
           1 - invio mail avvisi attivato
           0 - invio mail avvisi disattivato
		   
email = "STRING (path)"
        percorso (relativo o assoluto) del file degli indirizzi email di destinazione
        gli indirizzi email vanno inseriti nel file uno per ogni riga

checkprogram = "STRING (path)"
               percorso (relativo o assoluto) file output verifica stato del programma
               il valore viene poi restituito nella variabile lasttimestamp
               0 = il programma è nello stato normale
               UNIX TIMESTAMP (sec) = instante di tempo controllo post reboot vpn

resetprogram = INT (sec)
               timeout reset programma

```
<br>
Nota: originariamente i file sono stati creati su Windows.<br>
In caso di problemi legati alla formattazione, una soluzione semplice è la conversione attraverso tools come dos2unix.
