use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.


my $preop = 'find $(DISTVNAME) -type f -exec egrep -q ___EUMM_VERSION___ {} \; -exec sed -i "s/___EUMM_VERSION___/Build V$(VERSION)/" {} \; -print ;' .
'perldoc -uT $(DISTVNAME)/$(VERSION_FROM) > README.pod';

WriteMakefile(
    NAME              => 'Excel::Table',
    VERSION_FROM      => 'lib/Excel/Table.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Excel/Table.pm', # retrieve abstract from module
       AUTHOR         => 'tmcmeeki <tmcmeeki@cpan.org>') : ()),
	dist => { PREOP => $preop, 
	},
);
