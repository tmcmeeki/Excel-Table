use 5.010001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Excel::Table',
    VERSION_FROM      => 'lib/Excel/Table.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Excel/Table.pm', # retrieve abstract from module
       AUTHOR         => 'tmcmeeki <tmcmeeki@cpan.org>') : ()),
);
