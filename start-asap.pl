#!/usr/bin/env perl
use 5.012;
use warnings;
use JSON::PP;
use FindBin qw($RealBin);
use lib "$RealBin/lib";
use Spreadsheet::WriteExcel;	#conda install -c bioconda perl-spreadsheet-writeexcel 
use File::Basename;
use Getopt::Long;
use File::Spec;
use Pod::Usage;
my $VERSION = '1.0.0';
my $cmd_string = $RealBin . ' ' . join(' ', @ARGV);
my $opt_output;
my $opt_reads_dir;
my @opt_ref;
my $opt_project_name = 'ASA3P_Project';
my $opt_project_description = 'Isolate genomes sequencing';
my $opt_genus = 'Escherichia';
my $opt_user_name = 'Quadram';
my $opt_user_surname = 'Institute';
my $opt_user_mail = 'asap@exampe.com';
my $warnings = 0;
my $errors   = 0;
my $opt_copy;
my %title_font  = (font  => 'Arial', size  => 12,  bold  => 1, bg_color => 'silver');
my %monospace_font = ( font => 'Courier New', size => 11 );
my $opt_verbose;
my $opt_help;
my $opt_version;

GetOptions(
	'i|input-dir=s'  => \$opt_reads_dir,
	'r|reference=s'  => \@opt_ref,
	'o|output-dir=s' => \$opt_output,
	'g|genus=s'      => \$opt_genus,
	'c|copy-files=s' => \$opt_copy,
	'v|verbose'      => \$opt_verbose,
	'version'        => \$opt_version,
	'h|help'         => \$opt_help,
);

$opt_version && version();
pod2usage({-exitval => 0, -verbose => 2}) if $opt_help;
die usage() if (not defined $opt_reads_dir or not defined  $opt_output or not defined $opt_genus  or not defined $opt_ref[0]);

if (not defined $opt_reads_dir) {
	print STDERR "Please, specify reads directory with -i DIR (or --input-dir)\n";
	$errors++;
}
if (not defined $opt_output) {
	print STDERR "Please, specify output directory with -o DIR (or --output-dir)\n";
	$errors++;
}
if (not defined $opt_ref[0]) {
	print STDERR "Please, specify reference -r REFERENCE (or --reference)\n";
	$errors++;
}

exit if ($errors);

if (! -d "$opt_output") {
	mkdir "$opt_output" || die "FATAL ERROR:\nUnable to create project directory <$opt_output>.\n";
}
mkdir File::Spec->catdir("$opt_output", 'data');
my $config_file = File::Spec->catfile("$opt_output", 'config.xls');


my $workbook = init();

$workbook->close() or die "Error closing config.xls file: $!";


sub init {

	my $workbook = Spreadsheet::WriteExcel->new("$config_file");
	$workbook->compatibility_mode();
		my $title_format        = $workbook->add_format(%title_font);
		my $merged_title_format = $workbook->add_format(%title_font);
		my $monospace           = $workbook->add_format(%monospace_font);

	my $project_worksheet = $workbook->add_worksheet('Project');

		$project_worksheet->merge_range('A1:B1', 'Project', $merged_title_format);
		$project_worksheet->merge_range('A7:B7', 'User', $merged_title_format);
		$project_worksheet->merge_range('A13:B13', 'Reference genomes', $merged_title_format);
		$project_worksheet->write('E2', "Samplesheet generated with start-asap on " . getLoggingTime());
		$project_worksheet->write('E3', "https://github.com/quadram-institute-bioscience/start-asap/");

		$project_worksheet->write('E5', "Command string:");
		$project_worksheet->write('E6', "$cmd_string", $monospace);

		$project_worksheet->write('A2', "Name");
		$project_worksheet->write('A3', "Description");
		$project_worksheet->write('A4', "Genus");
		$project_worksheet->write('B2', "$opt_project_name");
		$project_worksheet->write('B3', "$opt_project_description");
		$project_worksheet->write('B4', "$opt_genus");

		$project_worksheet->write('A8', "Name");
		$project_worksheet->write('A9', "Surname");
		$project_worksheet->write('A10', "Email");
		$project_worksheet->write('B8', "$opt_user_name");
		$project_worksheet->write('B9', "$opt_user_surname");
		$project_worksheet->write('B10', "$opt_user_mail");

		$project_worksheet->write('A14', "Reference Genome List");
		$project_worksheet->write('B14', "ref_file1...");
		#$project_worksheet->write('B15', "Reference Genome List");

		$project_worksheet->set_column('A:A', '25');
		$project_worksheet->set_column('B:B', '40');
		$project_worksheet->set_column('E:E', '80');
	my $strains_worksheet = $workbook->add_worksheet('Strains');
	#Species	Strain	Input	File 1	[ File 2 ]	[ File 3 ]
		$strains_worksheet->write('A1', 'Species', $title_format);	# species name like 'coli'
		$strains_worksheet->write('B1', 'Strain', $title_format);	# has to be unique (ID)
		$strains_worksheet->write('C1', 'Input', $title_format);	# single paired-end contigs genome
		$strains_worksheet->write('D1', 'File 1', $title_format);
		$strains_worksheet->write('E1', '[ File 2 ]', $title_format);
		$strains_worksheet->write('F1', '[ File 3 ]', $title_format);

		$strains_worksheet->set_column('A:C', '15');
		$strains_worksheet->set_column('D:F', '35');

		return $workbook;
}

sub getLoggingTime {

    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
    my $nice_timestamp = sprintf ( "%04d-%02d-%02d %02d:%02d:%02d",
                                   $year+1900,$mon+1,$mday,$hour,$min,$sec);
    return $nice_timestamp;
}

sub verbose {
	return 0 if not defined $opt_verbose;
}
sub version {
    # Display version if needed
    die "start-asap.pl $VERSION\n";
}
 
sub usage {
    # Short usage string in case of errors
    die "start-asap.pl -i READS_DIR -r REFERENCE -o OUT_DIR -g Genus\n";
}
__END__
 
=head1 NAME
 
B<start-asap.pl> - Create a config.xml file for the ASA3P pipeline
 
=head1 AUTHOR
 
Andrea Telatin <andrea.telatin@quadram.ac.uk>
 
=head1 SYNOPSIS
 
start-asap.pl -i READS_DIR -r REFERENCE_FILE -o OUTPUT_DIR -g GENUS
 
=head1 DESCRIPTION
 
After running jellyfish with a particular KMERLEN and one or more FASTQ files,
determine the PEAK using jellyplot.pl and find_valleys.pl. Next, use this
PEAK as well as the KMERLEN and the FASTQ files used in the jellyfish run
as input. The script will determine the coverage and genome size.
 
=head1 PARAMETERS
 
=over 4
 
=item I<-i>, I<--input-dir> DIRECTORY

Directory containing the raw reads in FASTQ format. 

=item I<-r>, I<--reference> FILE

Reference file in FASTA or GBK format (other formats are supported by ASA3P, but have not been tested)

=item I<-o>, I<--output-dir> DIRECTORY

Project directory that will be the input of ASA3P. Will be created if not exists and
a C<config.xml> file will be placed there. The directory will contain a C<data> subdirectory,
left empty by default.

=item I<-c>, I<--copy-files> 

Place a copy of the reads and reference files in the C<./data> subdirectory.

 
=back
 
=head1 BUGS
 
Please report them to <andrea@telatin.com>
 
=head1 COPYRIGHT
 
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
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
=cut