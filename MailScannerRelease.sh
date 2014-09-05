#!/usr/bin/perl

$quarantine_dir = '/var/spool/MailScanner/quarantine';
$days_to_keep   = 1;

# Standardise the format of the directory name
die 'Path for quarantine_dir must be absolute' unless $quarantine_dir =~ /^\//;
$quarantine_dir =~ s/\/$//; # Delete trailing slash

# Now get the content list for the directory.
opendir(QDIR, $quarantine_dir) or die "Couldn't read directory $quarantine_dir";

# Loop through this list looking for any *directory* which hasn't been
# modified in the last $days_to_keep days.
# Unfortunately this will do nothing if the filesystem is backed up using tar.
while($entry = readdir(QDIR)) {
        next if $entry =~ /^\./;
        $entry = $quarantine_dir . '/' . $entry;
        system("rm -rf $entry") if -d $entry &&
                                   -M $entry > $days_to_keep;
}
closedir(QDIR);
