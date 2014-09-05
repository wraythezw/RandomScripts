#!/usr/bin/perl
# https://github.com/wraythezw/RandomScripts/
# Email keith.rose.zw@gmail.com
# Licensed under the MIT License
$quarantine_dir = '/var/spool/MailScanner/quarantine';
$days_to_keep   = 1;

die 'Path for quarantine_dir must be absolute' unless $quarantine_dir =~ /^\//;
$quarantine_dir =~ s/\/$//; # Delete trailing slash

opendir(QDIR, $quarantine_dir) or die "Couldn't read directory $quarantine_dir";

while($entry = readdir(QDIR)) {
        next if $entry =~ /^\./;
        $entry = $quarantine_dir . '/' . $entry;
        system("rm -rf $entry") if -d $entry &&
                                   -M $entry > $days_to_keep;
}
closedir(QDIR);
