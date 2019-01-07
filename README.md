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

## Per iniziare 

### Test del file UGOV

Si supponga che il file excel scaricato da U-GOV con la situazione attuale
degli inventari sia "tmp/ELENCO\ BENI1.xls"

Attraverso il task 

```bash
rake almaassets:show_excel_headers tmp/ELENCO\ BENI1.xls 
```

si vedono i campi che verranno utilizzati e il mapping tra il 
nome della colonna nell'header del file excel e quello che usiamo nel programma
come attributo (o metodo) del bene.

Per exempio: "Num inventario Ateneo" diventa "unibo_number"

Il task 

```bash
rake almaassets:test_file tmp/ELENCO\ BENI1.xls 
```

mostra invece il contenuto excel con una pagina per ogni bene.

### Popolare gli utenti

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

con i dati dei vostri utenti (per ora `organization_id=1`).

### Popolare gli oggetti inventariati

```bash
rake almaassets:insert_or_update_assets tmp/ELENCO\ BENI1.xls
```

### Associare, per quanto possibile, gli utenti

Gli utenti in UGOV sono id nel campo 'Codice Possessore' (boh) o stringhe in 'Possessore' 
oppure compaiono in 'Descrizione bene'. 

Con 

```bash
rake almaassets:assign_users 
```

il task prova ad azzeccare quello che ha inserito l'operatore a mano e associarlo
ad uno degli utenti che avete inserito nel database.

Avrete comunque da modificare a mano `lib/tasks/assign_users.rake` per soddisfare le vostre esigenze.

Si tratta essenzialmente di una serie di regular expressions per indovinare a chi è 
assegnato il materiale.

### Associare, per quanto possibile, le categorie

Inserite le categorie che volete trattare via interfaccia o direttamente nel
database tipo

```mysql
INSERT INTO `categories` VALUES (1, 'notebook', 'Pc portatile', '', 1), (0, 'pc', 'Pc fisso', '', 2), (0, 'printer', 'Stampante', '', 3), (0, 'tablet', 'Tablet', '', 4), (0, 'monitor', 'Monitor', '', 5), (0, 'video', 'Videocamera - Tv', '', 6), (0, 'hd', 'Hard disk esterno', '', 7), (0, 'projector', 'Projector', '', 8), (0, 'server', 'Server e accessori', '', 9), (0, 'audio', 'Audio', '', 10), (0, 'software', 'Software, licenze', '', 11), (0, 'chair', 'Sedia, Armadio, Tavolo', '', 12);
```

e modificate di conseguenza `lib/tasks/assign_categories.rake`.

Anche quì si tratta di una serie di regular expressions per indovinare la tipologia
di materiale.

Quindi eseguite il task

```bash
rake almaassets:assign_categories 
```






