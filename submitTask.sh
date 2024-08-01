#!/bin/bash
while IFS=' ' read -r name rollno domains confirmation
do
  # Skip if confirmation contains "Mentors"
  if echo "$confirmation" | grep -q "Mentors"; then
    continue
  fi

  # Allocate mentors based on domains
  for domain in web app sysad; do
    if echo "$domains" | grep -q "$domain"; then
      while true; do
        mentor=$(ls -d "/home/admin/mentors/$domain"/*/ | shuf -n 1)
        capfile="${mentor}cap.txt"
        
        if [ -f "$capfile" ]; then
          capleft=$(<"$capfile")
          echo "Mentor: $mentor, Cap Left: $capleft"

          if [ "$capleft" -gt 0 ]; then
            sudo sh -c "echo '$name $rollno' >> ${mentor}allocatedMentees.txt"
            cat "${mentor}allocatedMentees.txt"
            capleft=$((capleft-1))
            echo "$capleft" | sudo tee "$capfile" > /dev/null
            sed -i "/^$name $rollno $domains/c\\$name $rollno $domains Mentors allocated" /home/admin/mentees_domain.txt
            break
          else
            echo "No capacity left for mentor $mentor"
            break
          fi
        else
          echo "Capacity file $capfile not found for mentor $mentor"
          break
        fi
      done
    fi
  done
done < /home/admin/mentees_domain.txt
