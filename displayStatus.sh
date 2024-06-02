#!/bin/bash
mentee_count=$(wc -l < mentees_domain.txt)
mentee_webcount=$(grep -c "web" mentees_domain.txt)
mentee_appcount=$(grep -c "app" mentees_domain.txt)
mentee_sysadcount=$(grep -c "sysad" mentees_domain.txt)
web_submitted_task1=0
app_submitted_task1=0
sysad_submitted_task1=0
web_submitted_task2=0
app_submitted_task2=0
sysad_submitted_task2=0
web_submitted_task3=0
app_submitted_task3=0
sysad_submitted_task3=0
while IFS= read -r line
do
 line=($line)
 name="${line[0]}"
 for domain in web app sysad; do
  if grep -q "$domain" <<< "${line[2]}"; then
   count=1
   for tasks in /home/admin/mentees/"$name"/"$domain"/task{1..3}; do
    if [[ -d "$tasks" && $(ls -A "$tasks") ]]; then
     task_no="$count"
     eval "${domain}_submitted_task${task_no}=\$(( ${domain}_submitted_task${task_no} + 1 ))"
    fi
    (( count ++))
   done
  fi
 done
done < mentees_domain.txt
task1total=$(( web_submitted_task1 + app_submitted_task1 + sysad_submitted_task1 ))
task2total=$(( web_submitted_task2 + app_submitted_task2 + sysad_submitted_task2 ))
task3total=$(( web_submitted_task3 + app_submitted_task3 + sysad_submitted_task3 ))

for tasks in 1 2 3; do
  for domain in web app sysad; do
    domain_var="${domain}_submitted_task${tasks}"
    mentee_var="mentee_${domain}count"
    var=$(( (${!domain_var} * 100) / ${!mentee_var} ))  # Used indirect variable reference
    echo "${domain} domain task ${tasks} submissions % is $var."
  done
  total_var="task${tasks}total"
  total=$(( (${!total_var} * 100) / mentee_count ))  # Used indirect variable reference
  echo "All domains task ${tasks} submissions % is $total."
done


last_run="/home/admin/last_run_timestamp.txt"
current_timestamp=$(date +%s)
last_run_timestamp=$(cat "$last_run" 2>/dev/null || echo 0)
echo "$current_timestamp" > "$last_run"

submitted_mentees=$(find /home/admin/mentees/*/*/task{1..3} -type d -newermt "@$last_run_timestamp" -exec bash -c 'echo ${1%/*/*/*}' _ {} \; | sort -u)
home/admin/mentors/"$domain"/"$name"/"${line[0]}"/
if [[ -z "$submitted_mentees" ]]; then
  echo "No mentees submitted tasks since the last run."
else
  echo "Mentees who submitted tasks since the last run: $submitted_mentees"
fi
