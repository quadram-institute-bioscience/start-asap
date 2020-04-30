# NAME

**start-asap.pl** - Create a config.xml file for the ASA3P pipeline

# AUTHOR

Andrea Telatin <andrea.telatin@quadram.ac.uk>

### SYNOPSIS

```
start-asap.pl -i READS\_DIR -r REFERENCE\_FILE -o OUTPUT\_DIR -g GENUS

```
### DESCRIPTION

After running jellyfish with a particular KMERLEN and one or more FASTQ files,
determine the PEAK using jellyplot.pl and find\_valleys.pl. Next, use this
PEAK as well as the KMERLEN and the FASTQ files used in the jellyfish run
as input. The script will determine the coverage and genome size.

### PARAMETERS

- _-i_, _--input-dir_ DIRECTORY

    Directory containing the raw reads in FASTQ format. 

- _-r_, _--reference_ FILE

    Reference file in FASTA or GBK format (other formats are supported by ASA3P, but have not been tested)

- _-o_, _--output-dir_ DIRECTORY

    Project directory that will be the input of ASA3P. Will be created if not exists and
    a `config.xml` file will be placed there. The directory will contain a `data` subdirectory,
    left empty by default.

- _-c_, _--copy-files_ 

    Place a copy of the reads and reference files in the `./data` subdirectory.

### BUGS

Please open an issue in the [repository](https://github.com/quadram-institute-bioscience/start-asap)

### COPYRIGHT

Copyright (C) 2019-2020 Andrea Telatin 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see &lt;http://www.gnu.org/licenses/>.
