#!/bin/bash

name=$(whoami)

   echo "Enter your preference with a space: " 
   read pref1 pref2 pref3 
   values=("$pref1" "$pref2" "$pref3")
   for ((i=0;i<${#values[@]};i++)); do
      case ${values[$i]} in
        1) values[$i]="web" ;;
        2) values[$i]="app" ;;
        3) values[$i]="sysad" ;;
      esac
   done
   while IFS= read -r line
   do
     line=($line)
     name1=${line[0]}
     if [ "$name" = "$name1" ]; then
        rollno=${line[1]}
        echo "$rollno"
     fi
   done < /home/admin/menteeDetails.txt
   echo "'$name' '$rollno' '${values[0]}'=>'${values[1]}'=>'${values[2]}'" >>/home/admin/mentees_domain.txt
   echo "'$values[0]}'=>'${values[1]}'=>'$values[2]}'" > /home/admin/mentees/"$name"/domain_pref.txt
   if [ -n "${values[0]}" ]; then
    sudo mkdir /home/admin/mentees/"$name"/"${values[0]}"
   fi
   if [ -n "${values[1]}" ]; then
    sudo mkdir /home/admin/mentees/"$name"/"${values[1]}"
   fi
   if [ -n "${values[2]}" ]; then
    sudo  mkdir /home/admin/mentees/"$name"/"${values[2]}"
   fi
