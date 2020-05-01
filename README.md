<img align="right" width="250" height="250" src="docs/asap.png">

# start-asap

[![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat)](http://bioconda.github.io/recipes/start-asap/README.html)


Initialize an [ASA³P](https://github.com/oschwengers/asap#readme) configuration file in **Excel** format (as required by ASA³P) from the command line. ASA³P is a fully featured bacterial assembly and analysis pipeline ([paper](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1007134)).

### Features
 * Can prepare the ASA³P project directory in a non-interactive way
 * Can use project metadata from a JSON file
 
 
### Usage

```
start-asap -i READS_DIR -r REFERENCE -o OUTDIR [-p METADATA_JSON | -g GENUS -s SPECIES]
```

See the [documentation](docs/usage.md) page.

### Installation

* Clone the repository and run `start-asap`, should work on most systems
* Install via BioConda with `conda install -c bioconda start-asap`


<img align="right" width="122" height="122" src="docs/xls.png">

### Output

The program can create an Excel file (`config.xls`) in the project directory, and optionally can copy the input files int he correct `./data` subdirectory

The output file contains, as required two workbooks: 

* Project

[![Project metadata](docs/sample.png)](docs/usage.md)

* Strains

[![Strains workbook](docs/info.png)](docs/usage.md)
