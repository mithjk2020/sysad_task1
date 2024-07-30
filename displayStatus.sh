#!/bin/bash
mentee_count=$(wc -l < mentees_domain.txt)
mentee_webcount=$(grep -c "web" mentees_domain.txt)
mentee_appcount=$(grep -c "app" mentees_domain.txt)
mentee_sysadcount=$(grep -c "sysad" mentees_domain.txt)

echo "Mentee counts: web=$mentee_webcount, app=$mentee_appcount, sysad=$mentee_sysadcount, total=$mentee_count"

# Initialize counts
web_submitted_task1=0
web_submitted_task2=0
web_submitted_task3=0
app_submitted_task1=0
app_submitted_task2=0
app_submitted_task3=0
sysad_submitted_task1=0
sysad_submitted_task2=0
sysad_submitted_task3=0

while IFS=' ' read -r name rollno domains confirmation; do
  
  for domain in web app sysad; do
    if echo "$domains" | grep -q "$domain"; then
      count=1
      for task_dir in /home/admin/mentees/"$name"/"$domain"/{1..3}; do
        if [ -d "$task_dir" ]; then
          task_no="$count"
          case $domain in
            web)
              eval "web_submitted_task${task_no}=\$(( web_submitted_task${task_no} + 1 ))"
              ;;
            app)
              eval "app_submitted_task${task_no}=\$(( app_submitted_task${task_no} + 1 ))"
              ;;
            sysad)
              eval "sysad_submitted_task${task_no}=\$(( sysad_submitted_task${task_no} + 1 ))"
              ;;
          esac
        fi
      (( count++ ))
      done
    fi
  done
done < mentees_domain.txt

# Calculate totals
task1total=$(( web_submitted_task1 + app_submitted_task1 + sysad_submitted_task1 ))
task2total=$(( web_submitted_task2 + app_submitted_task2 + sysad_submitted_task2 ))
task3total=$(( web_submitted_task3 + app_submitted_task3 + sysad_submitted_task3 ))

echo "Task totals: task1total=$task1total, task2total=$task2total, task3total=$task3total"

for tasks in 1 2 3; do
  for domain in web app sysad; do
    domain_var="${domain}_submitted_task${tasks}"
    mentee_var="mentee_${domain}count"

    if [[ ${!mentee_var} -ne 0 ]]; then
      var=$(( (${!domain_var} * 100) / ${!mentee_var} ))
      echo "${domain} domain task ${tasks} submissions % is $var."
    else
      echo "No mentees or mentee count is zero for $domain domain in task $tasks."
    fi
  done

  total_var="task${tasks}total"
  if [[ $mentee_count -ne 0 ]]; then
    total=$(( (${!total_var} * 100) / mentee_count ))
    echo "All domains task ${tasks} submissions % is $total."
  else
    echo "Total mentee count is zero for task $tasks."
  fi
done
