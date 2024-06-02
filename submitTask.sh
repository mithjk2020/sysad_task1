#!/bin/bash
name=$(whoami)
if [[ "/home/admin/mentees/$name" == "$(getent passwd $name | cut -d: -f6)" ]]; then
 read -p "Enter task domain(all letter in small): " dom
 read -p "Enter task number" taskno
 sed -i -E "/^\s*$dom:/,/^\s*$/ s/Task$taskno:.*/Task$taskno: y/" /home/admin/mentees/"$name"/task_submitted.txt
 sudo mkdir /home/admin/mentees/"$name"/"$dom"/"$taskno"
 echo "Not empty" > /home/admin/mentees/"$name"/"$dom"/"$taskno"
fi 
 
elif [[ "/home/admin/mentors/web/$name" == "$(getent passwd $name | cut -d: -f6)" || \
        "/home/admin/mentors/app/$name" == "$(getent passwd $name | cut -d: -f6)" || \
        "/home/admin/mentors/sysad/$name" == "$(getent passwd $name | cut -d: -f6)" ]]; then
 domain=$(basename $(dirname "$(getent passwd '$name' | cut -d: -f6)"))
 while IFS= read -r line
 do
  line=($line)
  name1="${line[0]}"
  count=1
  for tasks in /home/admin/mentees/"$name1"/"$domain"/task{1..3}; do
   if [[ -d "$tasks" && $(ls -A "$tasks") ]]; then
    task_no="$count"
    sudo sed -i -E "/^\s*$domain:/,/^\s*$/ s/Task$task_no:.*/Task$task_no: y/" /home/admin/mentees/"$name1"/task_completed.txt
    sudo ln -sf "$tasks" "/home/admin/mentors/$domain/$name/submittedTasks/$task_no/$name1"
   fi
   (( count += 1))
  done
 done < /home/admin/mentees_domain.txt
 
 
else
 echo "No such mentor or mentee exist!"
fi

