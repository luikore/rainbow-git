## Setup

``` sh
brew install node
brew install postgres
brew install icu4c
pip install pygments
cp config/database.yml.example config/database.yml
```

You should open a new tab if using zsh, because it caches command paths ... To init database

``` sh
initdb /usr/local/var/postgres
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
createuser admin
```

You can alias pg.start / pg.stop

``` sh
alias pg.start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg.stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
```

If you installed the pg gem **before** `brew install postgres`, it's linked to the wrong binary, to fix it:

``` sh
gem pristine pg
```

## Useful Links

http://postgres.cz/wiki/PostgreSQL_SQL_Tricks
