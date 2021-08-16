# How to use PsychoStats Docker setup
Purpose of this Docker setup is to unify development environment in between developers, provide fast and
easy way to how to spin up project.

## Architecture
Docker setup has following containers:
- mysql - provides MariaDB server on port 3336
- www - runs PHP 7.4 and Apache server, provides HTTP server on port 8001
- daemon - environment ready to run perl scripts

All commands must be run from root folder.

## How to

To perform first run, you have to do several things in advance:
- copy PsychoStats mod files to their places
- provide db dump into `docker-compose/mysql/dump/` to initialize Database. If there will be no dump,
  db will initialize empty.

To spin up the project just build the images and start the containers:
```
$ docker-compose up --build
```
First run can take several minutes, since the images have to be pulled and build first. At the end, you
should see something like:
```
Starting psychostats_mysql_1 ... done
Recreating psychostats_www_1    ... done
Recreating psychostats_daemon_1 ... done
```

Then logs from containers will appear, and you can proceed to your browser.


### Using install script
If you dont need to init database from scratch, and you have a database dump, you 
can put it into `docker-compose/mysql/dump` folder and then just run auto-installation script
`./scripts/install.sh <mod_name>`. This script will clone mod and copy its content to PsychoStats folder. Also it
copies configs that are necessary to run docker setup to their places and removes
the `install` folder. It also tweaks git to assume content of install folder unchanged.

To revert git tweak just run:
```
cd PsychoStats && git ls-files www/install | xargs git update-index --no-assume-unchanged 
```

This creates configuration files suitable for Docker setup and deletes `www/install` folder.



## Usage
### MySQL
To access MySQL, you can use following credentials:
- db: psychostats3_1
- user: ps3
- pwd: password
- user: root
- pwd: root_password

### WWW
You can access your psychostats server on [http://localhost:8001](http://localhost:8001).


### Daemon
You have to run log parsers in the container, you can do it manually:
```
docker run --name psychostats.daemon psychostats.daemon perl stats.pl
```

or you can use script:
```
./scripts/run.sh stats.pl
```


