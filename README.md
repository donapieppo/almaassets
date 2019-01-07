# ALMAAssets

Partendo dal file excel (generato da U-GOV e letto con Roo::Excel) con la situazione
inventariale del Dipartimento e dall'elenco degli utenti del Dipartimento,
popoliamo un database e forniamo un'applicazione web per gestire l'associazione
tra gli utenti e i beni e permettere agli utenti varie operazioni tra cui
confermare l'attuale presenza del bene.

## Installazione

Applicazione piuttosto standard in ruby on rails su mysql. 
`git clone` e poi `rake db schema load`.

## Per iniziare

Si supponga che il file excel scaricato da U-GOV con la situazione attuale
degli inventari sia "tmp/ELENCO\ BENI1.xls"

Attraverso il task 

```ruby
rake almaassets:show_excel_headers tmp/ELENCO\ BENI1.xls 
```

si vedono i campi che verranno utilizzati e il mapping tra il 
nume in excel e quello che usiamo nel programma.

Per exempio: "Num inventario Ateneo" diventa "unibo_number"

Il task 

```ruby
rake almaassets:show_excel_headers
```
invece carica il file 



