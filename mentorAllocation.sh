#!/bin/bash
while IFS= read -r line
do
  line=($line)
  name=${line[0]}
  rollno=${line[1]}
  domains=${line[2]}
  confirmation=${line[3]}
  if echo "$confirmation" | grep -q "Mentors allocated"; then
    continue
  else
    # Check and assign mentors based on domains
    if echo "$domains" | grep -q "web"; then
      while true; do
        mentor=$(ls -d "/home/admin/mentors/web"/*/ | shuf -n 1)
        capleft=$(<"${mentor}cap.txt")
        echo "Mentor: $mentor, Cap Left: $capleft"
        if [[ "$capleft" -gt 0 ]]; then
          sudo sh -c "echo '$name $rollno' >> ${mentor}allocatedMentees.txt"
          cat "${mentor}allocatedMentees.txt"
          capleft=$((capleft-1))
          echo "$capleft" | sudo tee "${mentor}cap.txt" > /dev/null
          sed -i "s/^$line/$line Mentors allocated/" /home/admin/mentees_domain.txt
          break
        fi
      done
    fi

    if echo "$domains" | grep -q "app"; then
      while true; do
        mentor=$(ls -d "/home/admin/mentors/app"/*/ | shuf -n 1)
        capleft=$(<"${mentor}cap.txt")
        echo "Mentor: $mentor, Cap Left: $capleft"
        if [[ "$capleft" -gt 0 ]]; then
          sudo sh -c "echo '$name $rollno' >> ${mentor}allocatedMentees.txt"
          cat "${mentor}allocatedMentees.txt"
          capleft=$((capleft-1))
          echo "$capleft" | sudo tee "${mentor}cap.txt" > /dev/null
          sed -i "s/^$line/$line Mentors allocated/" /home/admin/mentees_domain.txt
          break
        fi
      done
    fi

    if echo "$domains" | grep -q "sysad"; then
      while true; do
        mentor=$(ls -d "/home/admin/mentors/sysad"/*/ | shuf -n 1)
        capleft=$(<"${mentor}cap.txt")
        echo "Mentor: $mentor, Cap Left: $capleft"
        if [[ "$capleft" -gt 0 ]]; then
          sudo sh -c "echo '$name $rollno' >> ${mentor}allocatedMentees.txt"
          cat "${mentor}allocatedMentees.txt"
          capleft=$((capleft-1))
          echo "$capleft" | sudo tee "${mentor}cap.txt" > /dev/null
          sed -i "s/^$line.*/& Mentors allocated/" /home/admin/mentees_domain.txt
          break
        fi
      done
    fi
  fi
done < /home/admin/mentees_domain.txt
