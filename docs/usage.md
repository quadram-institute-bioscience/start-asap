### NAME

**start-asap.pl** - Create a config.xml file for the ASA3P pipeline

### AUTHOR

Andrea Telatin <andrea.telatin@quadram.ac.uk>

### SYNOPSIS

```
start-asap.pl -i READS_DIR -r REFERENCE_FILE -o OUTPUT_DIR -g GENUS
```

### DESCRIPTION

Prepare the input directory for 'ASA3P', creating automatically a _config.xls_ file from the reads provided.
Requires:
* One or more reference files (.gbk recommended)
* A directory with FASTQ files (.fq or .fastq, gzipped)


### MAIN PARAMETERS

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

- _-ft_, _--for-tag_ STRING

    Identify reads as forward if they contain the string (default: "_R1")

- _-rt_, _--rev-tag_ STRING

    Identify reads as reverse if they contain the string (default: "_R2")

- _-it_, _--id-separator_ STRING 

    Split the file name and the first part will be the sample ID (and strain name). Will abort if more than one sample results in the same ID (default: "_")



**project metadata**: See the METADATA section

### METADATA

For each project the following metadata is required, that can be provided either from the command line or with a JSON file
like the following:

    {
       "user_name" : "Andrea",
       "user_mail" : "info@example.com",
       "user_surname" : "Telatin",
       "project_name": "MaxiSeq",
       "project_description" : "Resequencing of 1230 E. coli isolates",
       "genus" : "Escherichia",
	   "species:" "coli",
       "project_name" : "Example project"
    }

- _-p_, _--project-info_ JSON\_FILE

    A JSON file with project metadata. 

Alternatively (will override JSON metadata):

- _g_, _--genus_ STRING

Genus of the bacteria (default: "Escherichia")

- _s_, _--species_ STRING

Species of the bacteria (default: "coli")

- _--project-name_ STRING

    Project code name

- _--project-description_ STRING

    A description for the project

- _--user-name_ STRING

    First name of the project customer

- _--user-surname_ STRING

    Last name of the project customer

- _--user-mail_ STRING

    Email address name of the project customer

### BUGS

Open an issue in the GitHub repository 
[https://github.com/quadram-institute-bioscience/start-asap](https://github.com/quadram-institute-bioscience/start-asap).

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
along with this program.  If not, see [http://www.gnu.org/licenses](http://www.gnu.org/licenses).
