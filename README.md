# SKCGameJam2025

### Igrac

Igrac vidi iskljucivo tile-ove oko sebe. u jednom potezu moze da se pomeri ili da napadne (u jednom od 4 smera). Ako nije odmah pored stvari koje napada, ispaljuje metak, u suprotnom vrsi 'melee' napad. Ima 3 srca, koja kada izgubi, gubi nivo. Ima 3 metka koja koristi za pucanje.
Poenta igre mu je da unisti zarazene delove fotelja, a poeni se racunaju tako sto se na neki nacin na kraju nivoa sabiraju sve preostale fotelje.
### Fotelja

Fotelja zauzima \[1, 3\] tile-ova, kao fotelja/dvosed/trosed irl. Delovi mogu da budu razneseni, i tako dobijaju malo drugaciju teksturu na raznesenoj ivici. Nestaje kada su razneseni svi delovi (tile-ovi).

### Namestaj

Postoji jos vrsta namestaja (stolovi, lampe, kutije). Ne mogu biti zaposednuti ali mogu biti unisteni. 
- Sto nema nikakve posebne karakteristike.
- Lampa osijava tile-ove oko sebe.
- Kutija, nakon unistenja, na pod ostavlja pickup. (metkovi, powerup...)
### Virus

Virus zauzima 1 tile unutar neke fotelje. Ako se nalazi u fotelji, on moze da je pomera ili da napada iz nje (na nacin koji zavisi od vrste virusa, ali recimo samo obican melee napad na igraca za sad). Takodje moze da predje na susedni tile ukoliko se na njemu nalazi fotelja ili deo fotelje.

### Ideja

Tepih - pod na kojem fotelje pri pomeranju ostavljaju trag.