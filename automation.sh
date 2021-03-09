#!/usr/bin/env bash


# Separate all current data to the .csv below
rm -f /home/matt/automation/all_idopont.csv
cat /home/matt/automation/idopont/* > /home/matt/automation/all_idopont.csv

rm -f /home/matt/automation/all_ajandek.csv
cat /home/matt/automation/ajandek/* > /home/matt/automation/all_ajandek.csv



# Then, add every last week data to the main .csv files 

index_last_idopont=$(ls -v /home/matt/automation/idopontfoglalas | sort -V | tail -1)
cat /home/matt/automation/idopont/$index_last_idopont >> /home/matt/automation/all_idopont.csv
# Skip headers every time
tail -n +2 /home/matt/automation/idopont/$index_last_idopont >> /home/matt/automation/all_idopont.csv


index_last_ajandek=$(ls -v /home/matt/automation/ajandek | sort -V | tail -1)
cat /home/matt/automation/ajandek/$index_last_ajandek >> /home/matt/automation/all_ajandek.csv
# Skip for headers every time
tail -n +2 /home/matt/automation/ajandek/$index_last_ajandek >> /home/matt/automation/all_ajandek.csv
