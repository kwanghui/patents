use mysql;

/* Create patadmin account and assign privileges */
CREATE USER 'patadmin'@'localhost' IDENTIFIED BY 'xxxxadminpasswordxxxx';
GRANT USAGE ON *.* TO 'patadmin'@'localhost' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
GRANT ALL PRIVILEGES ON *.* TO 'patadmin'@'localhost' WITH GRANT OPTION;

/* Create patuser account and assign privileges */
CREATE USER 'patuser'@'localhost' IDENTIFIED BY 'xxxxuserpasswordxxxx';
GRANT USAGE ON *.* TO 'patuser'@'localhost' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
GRANT SHOW DATABASES, SHOW VIEW, SELECT ON *.* TO 'patuser'@'localhost';

/* Create database for Grants */
CREATE SCHEMA `grantdb` DEFAULT CHARACTER SET latin1;
/* Create database for Applications */
CREATE SCHEMA `applicationdb` DEFAULT CHARACTER SET latin1;
