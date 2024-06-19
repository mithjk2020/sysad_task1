sudo cp "/home/mithra/task/src/mentorDetails.txt" "/home/admin/"
sudo cp "/home/mithra/task/src/menteeDetails.txt" "/home/admin/"
sudo chown -R admin:admin /home/admin/{menteeDetails.txt,mentorDetails.txt}
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
