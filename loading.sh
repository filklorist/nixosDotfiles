#!/usr/bin/env bash


. ~/.dotfiles/progress_bar.sh

tasks_in_total=27
for current_task in $(seq $tasks_in_total)
    do
    sleep 0.2 #simulate the task running
    show_progress $current_task $tasks_in_total
done

echo -e "\nGood boy"
sleep 0.4
cat ~/.dotfiles/nixowows-banner.txt | lolcat
sleep 1
echo -e "\nSystem Online"
sleep 1
echo -e "\n\n\n\n\nFetching System Processes"
sleep 1
echo -e "\nFetching System Files"
sleep 2
echo -e "\nFetching Star Chart"
sleep 1
echo -e "\nHave fun"
sleep 3
