#!/bin/bash
name=${whoami}
echo "Enter quiz questions { ctrl+D to finish } : "
questions=$(cat)
current_path=$(pwd)
domain=$(echo "$current_path" | cut -d'/' -f3)
touch /home/admin/mentors/$domain/$name/quizQuestions.txt
chmod 755 /home/admin/mentors/$domain/$name/quizQuestions.txt
echo "$questions" >> /home/admin/mentors/$domain/$name/quizQuestions.txt
