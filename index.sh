#!/bin/bash
#MAIN SCRIPT


source ./_files/helpers/colors.sh
source ./_files/helpers/menu.sh
source ./_files/modules/Main.sh



for i in {1..5}; do
   renderMainMenu $i
done