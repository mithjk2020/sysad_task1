#!/bin/bash
while IFS= read -r line
do
 line=($line)
 name1=${line[0]}
 domain=${line[1]}
 while IFS= read -r line
 do
 line1={$line1}
 menteeName=${line1[0]}
 path_menteefile="/home/admin/mentees/$menteeName"
 sudo tee /home/admin/mentees/"$menteeName"/.bashrc > /dev/null <<EOF
filePath="/home/admin/mentors/$domain/$name1/quizQuestions.txt"
currentModifiedTime=\$(stat -c %Y "filePath")
checkFile="/home/admin/mentors/$domain/$name1/lastModified.txt"
if [[ -f "\$checkFile" ]]; then
 lastModifiedTime=\$(cat "\$checkFile")
 if [[ "\$lastModifiedTime" -ne "\$currentModifiedTime" ]]; then
  echo "\$currentModifiedTime" > "\$checkFile"
  notify-send "Quiz questions have been added."
 fi
else
 touch "\$checkFile"
 echo "\$currentModifiedTime" > "\$checkFile"
fi 
EOF
 done < /home/admin/mentors/"$domain"/"$name1"/allocatedMentees.txt
done < /home/admin/mentorDetails.txt

