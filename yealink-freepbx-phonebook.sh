#!/bin/bash
#
#       FreePBX Phonebook Creation Script
#      (c) Keith Rose All Rights Reserved.
#           keith.rose.zw@gmail.com
#             www.keithro.se

# Assumptions
# 1. Base FPBX install. Database in use = asterisk
# 2. Localhost requires no authentication
# 3. Standard Yealink XML Phonebook
# 4. Apache webdir = /var/www/html
# 5. CallerID format = EXTENSION - CALLERID. E.g 2000 - Keith Rose

echo "FreePBX Yealink Phonebook creation script."
echo "  (c) Keith Rose. All Rights Reserved."
echo "      keith.rose.zw@gmail.com"
echo "         www.keithro.se"
echo ""
echo ""

# Export Extension List to CSV
echo "1....Exporting DB"
mysql -B -e  "select name,extension from users;" asterisk | sed "s/'/\'/;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" > /tmp/exp1.csv
echo "2....Tidying up content"
# Remove first line
tail -n +2 /tmp/exp1.csv > /tmp/exp2.csv
# Remove content prior to hyphen. E.g "2000 - Keith Rose" becomes "Keith Rose"
awk 'BEGIN{FS=OFS="- "} NF>1{$1="";sub(/^- */, "")}'1 /tmp/exp2.csv > /tmp/exp3.csv
# Remove all double quotes
sed 's/\"//g' /tmp/exp3.csv > /tmp/exp4.csv

echo "3....Generating XML"
file_in="/tmp/exp4.csv"
file_out="/tmp/exp5.xml"
echo '<?xml version="1.0"?>' > $file_out
echo '<YealinkIPPhoneDirectory>' >> $file_out
while IFS=$',' read -r -a arry
do
  echo '  <DirectoryEntry>' >> $file_out
  echo '    <Name>'${arry[0]}'</Name>' >> $file_out
  echo '    <Telephone>'${arry[1]}'</Telephone>' >> $file_out
  echo '  </DirectoryEntry>' >> $file_out
done < $file_in
echo '</YealinkIPPhoneDirectory>' >> $file_out

echo "4....Copying phonebook to /var/www/html/phonebook.xml"
cp /tmp/exp5.xml /var/www/html/phonebook.xml
echo "5....Fixing permissions"
chmod 777 /var/www/html/phonebook.xml

echo "6....Tidying up"
# tidying up
rm /tmp/exp* -f

echo ""
echo ""
echo "    Export complete!!"
