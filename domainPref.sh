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
     fi
   done < /home/admin/menteeDetails.txt
   if [ -n "${values[2]}" ]; then
    echo "$name $rollno ${values[0]}=>${values[1]}=>${values[2]}" >>/home/admin/mentees_domain.txt
    echo "${values[0]}=>${values[1]}=>$values[2]}" > /home/admin/mentees/"$name"/domain_pref.txt
    mkdir /home/admin/mentees/"$name"/"${values[0]}"
    mkdir /home/admin/mentees/"$name"/"${values[1]}"
    mkdir /home/admin/mentees/"$name"/"${values[2]}"
   elif [ -n "${values[1]}" ]; then
    echo "$name $rollno ${values[0]}=>${values[1]}" >>/home/admin/mentees_domain.txt
    echo "${values[0]}=>${values[1]}" > /home/admin/mentees/"$name"/domain_pref.txt
    mkdir /home/admin/mentees/"$name"/"${values[0]}"
    mkdir /home/admin/mentees/"$name"/"${values[1]}"
   elif [ -n "${values[0]}" ]; then
    echo "$name $rollno ${values[0]}" >>/home/admin/mentees_domain.txt
    echo "${values[0]}" > /home/admin/mentees/"$name"/domain_pref.txt
    mkdir /home/admin/mentees/"$name"/"${values[0]}"
   fi
