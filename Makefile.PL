use strict;
use ExtUtils::MakeMaker;

my @exe_files = map {"bin/$_"} qw(cpandb);
my $goners = join ' ', qw(cpandb.sql
			  t/dot-cpan/cpandb.sql
			  t/dot-cpan/FTPstats.yml
			  t/dot-cpan/CPAN/MyConfig.pm
			  t/dot-cpan/cpan_sqlite_log.*
			  t/dot-cpan/sources/authors/01mailrc.txt.gz
			  t/dot-cpan/sources/modules/02packages.details.txt.gz
			  t/dot-cpan/sources/modules/03modlist.data.gz
			 );
my %opts = (
	    NAME => 'CPAN::SQLite',
            VERSION_FROM => 'lib/CPAN/SQLite.pm',
            EXE_FILES => \@exe_files,
            PL_FILES => {},
	    dist   => {
		       SUFFIX   => 'gz',
		       COMPRESS => 'gzip -9f',
		      },
	    clean => {FILES => $goners},
	   );

my $eu_version = $ExtUtils::MakeMaker::VERSION;
if ($eu_version >= 5.43) {
   $opts{ABSTRACT_FROM} = 'lib/CPAN/SQLite.pm';
   $opts{AUTHOR} = 'Randy Kobes <randy.kobes@gmail.com>';
}
if ($eu_version > 6.11 ) {
  $opts{NO_META} = 1;
}

my $prereqs = {'File::Spec' => 0,
               'Archive::Tar' => 1.08,
               'IO::Zlib' => 0,
               'Compress::Zlib' => 0,
               'CPAN::DistnameInfo' => 0.09,
               'DBD::SQLite' => 0,
	       'File::HomeDir' => 0,
	       'LWP::Simple' => 0,
	      };

WriteMakefile( %opts, PREREQ_PM => $prereqs);
