#!/bin/bash 
sudo useradd -m -d /home/admin admin
echo "admin:iamcore@2024" | sudo chpasswd
sudo mkdir -p /home/admin/mentors /home/admin/mentees
sudo cp "/home/mithra/mentorDetails.txt" "/home/admin/"
sudo cp "/home/mithra/menteeDetails.txt" "/home/admin/"
sudo chown -R admin:admin /home/admin/{mentees,mentors}
sudo chown -R admin:admin /home/admin/{menteeDetails.txt,mentorDetails.txt}
sudo chmod -R 755 /home/admin/{mentors,mentees}
sudo mkdir -p /home/admin/mentors/web /home/admin/mentors/app /home/admin/mentors/sysad
create(){
  sudo useradd -m -d /home/admin/mentors/$1/"$men" "$men"
  sudo chown -R "$men":"$men" /home/admin/mentors/$1/"$men"
  sudo chmod 755 /home/admin/mentors/$1/"$men"
  echo "$men:deltaforce@2024" | sudo chpasswd
  sudo touch /home/admin/mentors/$1/"$men"/allocatedMentees.txt
  sudo touch /home/admin/mentors/$1/"$men"/cap.txt
  sudo chmod 777 /home/admin/mentors/$1/"$men"/{cap.txt,allocatedMentees.txt}
  echo "$cap" | sudo tee /home/admin/mentors/$1/"$men"/cap.txt > /dev/null
  sudo mkdir -p /home/admin/mentors/$1/"$men"/submittedTasks/task{1..3}
}

while IFS= read -r line
do
   line=($line)
   name=${line[0]}
   sudo useradd -m -d /home/admin/mentees/"$name" "$name"
   sudo chown -R "$name":"$name" /home/admin/mentees/"$name"
   sudo chmod 755 /home/admin/mentees/"$name"
   echo "$name:deltaforce@2024" | sudo chpasswd
   sudo touch /home/admin/mentees/"$name"/{domain_pref.txt,task_completed.txt,task_submitted.txt}
   sudo chmod 777 /home/admin/mentees/"$name"/.bashrc
   sudo chmod 777 /home/admin/mentees/"$name"/{domain_pref.txt,task_completed.txt,task_submitted.txt}
   sudo chown "$name":"$name" /home/admin/mentees/"$name"/{domain_pref.txt,task_completed.txt,task_submitted.txt}
   sudo tee /home/admin/mentees/"$name"/task_submitted.txt > /dev/null <<EOF
   sysAd:
    Task1: n
    Task2: n
    Task3: n
   web:
    Task1: n
    Task2: n 
    Task3: n
   app:
    Task1: n
    Task2: n
    Task3: n
EOF
   sudo tee /home/admin/mentees/"$name"/task_completed.txt > /dev/null <<EOF
   sysAd:
    Task1: n
    Task2: n
    Task3: n
   web:
    Task1: n
    Task2: n 
    Task3: n
   app:
    Task1: n
    Task2: n
    Task3: n
EOF
done < menteeDetails.txt
while IFS= read -r line1
do
   line1=($line1)
   domain=${line1[1]}
   cap=${line1[2]}
   men=${line1[0]}
   if [ "$domain" = "web" ]; then
        create "web"
   elif [ "$domain" = "app" ]; then
        create "app"
   elif [ "$domain" = "sysad" ]; then
        create "sysad"
   fi
done < mentorDetails.txt
sudo touch /home/admin/mentees_domain.txt
sudo chmod 722 /home/admin/mentees_domain.txt

for mentees in "/home/admin/mentees"/*; do sudo cp "/home/mithra/task/src/submitTask.sh" "$mentees/"; done
for mentees in "/home/admin/mentees"/*; do sudo cp "/home/mithra/task/src/domainPref.sh" "$mentees/"; done
for mentors in "/home/admin/mentors/web"/*; do sudo cp "/home/mithra/task/src/submitTask.sh" "$mentors/"; done
for mentors in "/home/admin/mentors/app"/*; do sudo cp "/home/mithra/task/src/submitTask.sh" "$mentors/"; done
for mentors in "/home/admin/mentors/sysad"/*; do sudo cp "/home/mithra/task/src/submitTask.sh" "$mentors/"; done
sudo cp /home/mithra/task/src/mentorAllocation.sh /home/admin/
sudo cp /home/mithra/task/src/displayStatus.sh /home/admin/
for mentees in "/home/admin/mentees"/*; do sudo cp "/home/mithra/task/src/deRegister.sh" "$mentees/"; done
for mentees in "/home/admin/mentees"/*; do sudo cp "/home/mithra/task/src/setQuiz_mentee.sh" "$mentees/"; done
for mentors in "/home/admin/mentors/web"/*; do sudo cp "/home/mithra/task/src/setQuiz_mentor.sh" "$mentors/"; done
for mentors in "/home/admin/mentors/app"/*; do sudo cp "/home/mithra/task/src/setQuiz_mentor.sh" "$mentors/"; done
for mentors in "/home/admin/mentors/sysad"/*; do sudo cp "/home/mithra/task/src/setQuiz_mentor.sh" "$mentors/"; done
