# ALMAAssets

Partendo dal file excel (generato da U-GOV e letto con Roo::Excel) con la situazione
inventariale del Dipartimento e dall'elenco degli utenti del Dipartimento,
popoliamo un database e forniamo un'applicazione web per gestire l'associazione
tra gli utenti e i beni e permettere agli utenti varie operazioni tra cui
confermare l'attuale presenza del bene.

## Installazione

Applicazione piuttosto standard in ruby on rails su mariadb che utilizza 
(https://github.com/donapieppo/dm_unibo_common). 
Quindi, essenzialmente, `git clone`, `cp doc/dm_unibo_common.yml config/dm_unibo_common.yml` e poi `rake db schema load`.

## Per iniziare (tet del file UGOV)

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
rake almaassets:test_file tmp/ELENCO\ BENI1.xls 
```
mostra ivvece il contenuto excel con una pagina per ogni bene.

## Popolare gli utenti

Per popolare gli utenti deve essere riempita la tabella

```mysql
+-----------------+------------------+------+-----+---------+----------------+
| Field           | Type             | Null | Key | Default | Extra          |
+-----------------+------------------+------+-----+---------+----------------+
| id              | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| organization_id | int(10) unsigned | YES  | MUL | NULL    |                |
| upn             | varchar(255)     | NO   | MUL | NULL    |                |
| name            | varchar(255)     | YES  |     | NULL    |                |
| surname         | varchar(255)     | YES  |     | NULL    |                |
| email           | varchar(255)     | YES  |     | NULL    |                |
| updated_at      | datetime         | YES  |     | NULL    |                |
+-----------------+------------------+------+-----+---------+----------------+
```



