# Setup information

# Python scripts for processing USPTO inventor and patent data

The following collection of scripts performs pre- and post-processing on patent
data as part of the patent inventor disambiguation process. Raw patent data is
obtained from [Google Bulk Patent
Download](http://www.google.com/googlebooks/uspto-patents-grants-text.html).

For a high-level overview of the patentprocessor toolchain, please see [our
technical
report](https://github.com/funginstitute/publications/raw/master/patentprocessor/patentprocessor.pdf).

For a description of configuration of the patentprocessor toolchain, please see
[this technical
report](https://github.com/funginstitute/publications/raw/master/weeklyupdate/weeklyupdate.pdf).

To follow development, subscribe to
[RSS feed](https://github.com/funginstitute/patentprocessor/commits/master.atom).

## Patentprocessor Overview

There are several steps in the patentprocessor toolchain:

1. Retrieve/locate parsing target
2. Execute parsing phase
3. Run preliminary disambiguations:
    * assignee disambiguation
    * location disambiguation
4. Prepare input for inventor disambiguation
5. Disambiguate inventors (external process)
6. Ingest disambiguated inventors into database

For the preliminary disambiguations, you need the [location
database](https://s3.amazonaws.com/fungpatdownloads/geolocation_data.7z). File
requires [7zip](http://www.7-zip.org/) to unpack.

## Installation and Configuration of the Preprocessing Environment

The python-based preprocessor is tested on Ubuntu 12.04 and MacOSX 10.6.  Any
flavor of Unix with the following installed should work, though it is possible
to get the toolchain running on Windows.

If you have [`pip`](http://www.pip-installer.org/en/latest/index.html)
installed, you can simplify the installation process by just running `sudo pip
install -r requirements.txt` from within the patentprocessor directory.

Please [file an issue](https://github.com/funginstitute/patentprocessor/issues) if you find another dependency.

### Ubuntu 14.04 Installation #####

```
sudo apt-get update
sudo apt-get install -y python-dev python-setuptools
sudo easy_install -U distribute
sudo apt-get install -y python-Levenshtein make libmysqlclient-dev python-mysqldb python-pip python-zmq python-numpy gfortran libopenblas-dev liblapack-dev g++ sqlite3 libsqlite3-dev python-sqlite redis-server git

cd patent-project
sudo pip install -r requirements.txt
```