#!/bin/bash

# bash-weather is a weather report and forecast script written in Bash.
# Copyright (C) 2013 Istvan Szantai <szantaii at sidenote dot hu>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program (LICENSE).
# If not, see <http://www.gnu.org/licenses/>.

init()
{
	create_buffer
	
	left_padding=$(((term_width - min_term_width) / 2))
	top_padding=$(((term_height - min_term_height) / 2))
	
	if ${colored_output}
	then
		background_color_default="\e[49m"
		background_color_black="\e[40m"
		foreground_color_default="\e[39m"
		foreground_color_white="\e[97m"
		foreground_color_red="\e[91m"
		foreground_color_blue="\e[94m"
		foreground_color_yellow="\e[93m"
		foreground_color_green="\e[92m"
		foreground_color_light_gray="\e[37m"
		foreground_color_dark_gray="\e[90m"
		
		printf "%s${background_color_black}" >> ${buffer}
		printf "%s${foreground_color_white}" >> ${buffer}
	fi
	
	print_init_message
	refresh_screen
	
	ascii_font_0[0]="  ___  "
	ascii_font_0[1]=" / _ \ "
	ascii_font_0[2]="| | | |"
	ascii_font_0[3]="| | | |"
	ascii_font_0[4]="| |_| |"
	ascii_font_0[5]=" \___/ "
	
	ascii_font_1[0]=" __ "
	ascii_font_1[1]="/_ |"
	ascii_font_1[2]=" | |"
	ascii_font_1[3]=" | |"
	ascii_font_1[4]=" | |"
	ascii_font_1[5]=" |_|"
	
	ascii_font_2[0]=" ___  "
	ascii_font_2[1]="|__ \ "
	ascii_font_2[2]="   ) |"
	ascii_font_2[3]="  / / "
	ascii_font_2[4]=" / /_ "
	ascii_font_2[5]="|____|"
	
	ascii_font_3[0]=" ____  "
	ascii_font_3[1]="|___ \ "
	ascii_font_3[2]="  __) |"
	ascii_font_3[3]=" |__ < "
	ascii_font_3[4]=" ___) |"
	ascii_font_3[5]="|____/ "
	
	ascii_font_4[0]=" _  _   "
	ascii_font_4[1]="| || |  "
	ascii_font_4[2]="| || |_ "
	ascii_font_4[3]="|__   _|"
	ascii_font_4[4]="   | |  "
	ascii_font_4[5]="   |_|  "
	
	ascii_font_5[0]=" _____ "
	ascii_font_5[1]="| ____|"
	ascii_font_5[2]="| |__  "
	ascii_font_5[3]="|___ \ "
	ascii_font_5[4]=" ___) |"
	ascii_font_5[5]="|____/ "
	
	ascii_font_6[0]="   __  "
	ascii_font_6[1]="  / /  "
	ascii_font_6[2]=" / /_  "
	ascii_font_6[3]="| '_ \ "
	ascii_font_6[4]="| (_) |"
	ascii_font_6[5]=" \___/ "
	
	ascii_font_7[0]=" _______"
	ascii_font_7[1]="|____  /"
	ascii_font_7[2]="    / / "
	ascii_font_7[3]="   / /  "
	ascii_font_7[4]="  / /   "
	ascii_font_7[5]=" /_/    "
	
	ascii_font_8[0]="  ___  "
	ascii_font_8[1]=" / _ \ "
	ascii_font_8[2]="| (_) |"
	ascii_font_8[3]=" > _ < "
	ascii_font_8[4]="| (_) |"
	ascii_font_8[5]=" \___/ "
	
	ascii_font_9[0]="  ___  "
	ascii_font_9[1]=" / _ \ "
	ascii_font_9[2]="| (_) |"
	ascii_font_9[3]=" \__, |"
	ascii_font_9[4]="   / / "
	ascii_font_9[5]="  /_/  "
	
	ascii_font_min[0]="     "
	ascii_font_min[1]="     "
	ascii_font_min[2]=" ___ "
	ascii_font_min[3]="|___|"
	ascii_font_min[4]="     "
	ascii_font_min[5]="     "
	
	ascii_font_o[0]=" _ "
	ascii_font_o[1]="(_)"
	ascii_font_o[2]="   "
	ascii_font_o[3]="   "
	ascii_font_o[4]="   "
	ascii_font_o[5]="   "
	
	ascii_font_C[0]="  _____ "
	ascii_font_C[1]=" / ____|"
	ascii_font_C[2]="| |     "
	ascii_font_C[3]="| |     "
	ascii_font_C[4]="| |____ "
	ascii_font_C[5]=" \_____|"
	
	ascii_font_F[0]=" ______ "
	ascii_font_F[1]="|  ____|"
	ascii_font_F[2]="| |__   "
	ascii_font_F[3]="|  __|  "
	ascii_font_F[4]="| |     "
	ascii_font_F[5]="|_|     "
	
	ascii_icon_clear_sky_day[0]="${foreground_color_yellow}                   oo                   ${foreground_color_white}"
	ascii_icon_clear_sky_day[1]="${foreground_color_yellow}      .            **            .      ${foreground_color_white}"
	ascii_icon_clear_sky_day[2]="${foreground_color_yellow}       *'.         **         .'*       ${foreground_color_white}"
	ascii_icon_clear_sky_day[3]="${foreground_color_yellow}        '*o.       **       .o*'        ${foreground_color_white}"
	ascii_icon_clear_sky_day[4]="${foreground_color_yellow}          '*'     .''.     '*'          ${foreground_color_white}"
	ascii_icon_clear_sky_day[5]="${foreground_color_yellow}              .'********'.              ${foreground_color_white}"
	ascii_icon_clear_sky_day[6]="${foreground_color_yellow}             o************o             ${foreground_color_white}"
	ascii_icon_clear_sky_day[7]="${foreground_color_yellow}            o**************'            ${foreground_color_white}"
	ascii_icon_clear_sky_day[8]="${foreground_color_yellow}   'oooooo' **************** 'oooooo'   ${foreground_color_white}"
	ascii_icon_clear_sky_day[9]="${foreground_color_yellow}            '**************'            ${foreground_color_white}"
	ascii_icon_clear_sky_day[10]="${foreground_color_yellow}             '************'             ${foreground_color_white}"
	ascii_icon_clear_sky_day[11]="${foreground_color_yellow}               ,o******o,               ${foreground_color_white}"
	ascii_icon_clear_sky_day[12]="${foreground_color_yellow}         .o*'      **      '*o.         ${foreground_color_white}"
	ascii_icon_clear_sky_day[13]="${foreground_color_yellow}       ,o*'        **        '*o,       ${foreground_color_white}"
	ascii_icon_clear_sky_day[14]="${foreground_color_yellow}     ,o            **            o,     ${foreground_color_white}"
	ascii_icon_clear_sky_day[15]="${foreground_color_yellow}                   oo                   ${foreground_color_white}"
	
	ascii_icon_clear_sky_night[0]="${foreground_color_yellow}                  .,'o****o',.          ${foreground_color_white}"
	ascii_icon_clear_sky_night[1]="${foreground_color_yellow}               ,'*********oo'''.        ${foreground_color_white}"
	ascii_icon_clear_sky_night[2]="${foreground_color_yellow}            .o********',                ${foreground_color_white}"
	ascii_icon_clear_sky_night[3]="${foreground_color_yellow}           '********,                   ${foreground_color_white}"
	ascii_icon_clear_sky_night[4]="${foreground_color_yellow}         .********o                     ${foreground_color_white}"
	ascii_icon_clear_sky_night[5]="${foreground_color_yellow}         ********o                      ${foreground_color_white}"
	ascii_icon_clear_sky_night[6]="${foreground_color_yellow}        '********                       ${foreground_color_white}"
	ascii_icon_clear_sky_night[7]="${foreground_color_yellow}        ********o                       ${foreground_color_white}"
	ascii_icon_clear_sky_night[8]="${foreground_color_yellow}        ********o                       ${foreground_color_white}"
	ascii_icon_clear_sky_night[9]="${foreground_color_yellow}        '********,                      ${foreground_color_white}"
	ascii_icon_clear_sky_night[10]="${foreground_color_yellow}         o********.                     ${foreground_color_white}"
	ascii_icon_clear_sky_night[11]="${foreground_color_yellow}          o********'                    ${foreground_color_white}"
	ascii_icon_clear_sky_night[12]="${foreground_color_yellow}           '********o,                  ${foreground_color_white}"
	ascii_icon_clear_sky_night[13]="${foreground_color_yellow}             'o********o',.     .       ${foreground_color_white}"
	ascii_icon_clear_sky_night[14]="${foreground_color_yellow}               .,o************',        ${foreground_color_white}"
	ascii_icon_clear_sky_night[15]="${foreground_color_yellow}                   .'o***oo'.           ${foreground_color_white}"
	
	ascii_icon_few_clouds_day[0]="                                        "
	ascii_icon_few_clouds_day[1]="                                        "
	ascii_icon_few_clouds_day[2]="${foreground_color_light_gray}            .,,,,.         ${foreground_color_yellow}      |      ${foreground_color_white}"
	ascii_icon_few_clouds_day[3]="${foreground_color_light_gray}         .'oo''''''',.     ${foreground_color_yellow}  \   |   /  ${foreground_color_white}"
	ascii_icon_few_clouds_day[4]="${foreground_color_light_gray}       .oo,.       ..,'   ,${foreground_color_yellow}   \     /   ${foreground_color_white}"
	ascii_icon_few_clouds_day[5]="${foreground_color_light_gray}      .*'              ,,,,${foreground_color_yellow}    ,d8b,    ${foreground_color_white}"
	ascii_icon_few_clouds_day[6]="${foreground_color_light_gray}      ,o                   ${foreground_color_yellow}--- 88888 ---${foreground_color_white}"
	ascii_icon_few_clouds_day[7]="${foreground_color_light_gray}  ,,,,',                   ${foreground_color_yellow}    '98P'    ${foreground_color_white}"
	ascii_icon_few_clouds_day[8]="${foreground_color_light_gray},oo,                       ${foreground_color_yellow}   /     \   ${foreground_color_white}"
	ascii_icon_few_clouds_day[9]="${foreground_color_light_gray}o*,                        ${foreground_color_yellow}  /   |   \  ${foreground_color_white}"
	ascii_icon_few_clouds_day[10]="${foreground_color_light_gray}o*'                       ${foreground_color_yellow}       |   ${foreground_color_light_gray}'*o${foreground_color_white}"
	ascii_icon_few_clouds_day[11]="${foreground_color_light_gray}.o*o,,............................,,o*o.${foreground_color_white}"
	ascii_icon_few_clouds_day[12]="${foreground_color_light_gray}  'o******',o**********o,'**********o'  ${foreground_color_white}"
	ascii_icon_few_clouds_day[13]="                                        "
	ascii_icon_few_clouds_day[14]="                                        "
	ascii_icon_few_clouds_day[15]="                                        "
	
	ascii_icon_few_clouds_night[0]="                                        "
	ascii_icon_few_clouds_night[1]="                                        "
	ascii_icon_few_clouds_night[2]="${foreground_color_light_gray}            .,,,,.         ${foreground_color_yellow}       ____  ${foreground_color_white}"
	ascii_icon_few_clouds_night[3]="${foreground_color_light_gray}         .'oo''''''',.     ${foreground_color_yellow}    ,''8L,-\`.${foreground_color_white}"
	ascii_icon_few_clouds_night[4]="${foreground_color_light_gray}       .oo,.       ..,'   ,${foreground_color_yellow}  ,'88,'     ${foreground_color_white}"
	ascii_icon_few_clouds_night[5]="${foreground_color_light_gray}      .*'              ,,,,${foreground_color_yellow} /888/       ${foreground_color_white}"
	ascii_icon_few_clouds_night[6]="${foreground_color_light_gray}      ,o                   ${foreground_color_yellow}:888:        ${foreground_color_white}"
	ascii_icon_few_clouds_night[7]="${foreground_color_light_gray}  ,,,,',                   ${foreground_color_yellow}:888:        ${foreground_color_white}"
	ascii_icon_few_clouds_night[8]="${foreground_color_light_gray},oo,                       ${foreground_color_yellow} \888\       ${foreground_color_white}"
	ascii_icon_few_clouds_night[9]="${foreground_color_light_gray}o*,                        ${foreground_color_yellow}  \`.88\`._    ${foreground_color_white}"
	ascii_icon_few_clouds_night[10]="${foreground_color_light_gray}o*'                       ${foreground_color_yellow}     \`.9LL\`-.'${foreground_color_white}"
	ascii_icon_few_clouds_night[11]="${foreground_color_light_gray}.o*o,,............................,,o*o.${foreground_color_white}"
	ascii_icon_few_clouds_night[12]="${foreground_color_light_gray}  'o******',o**********o,'**********o'  ${foreground_color_white}"
	ascii_icon_few_clouds_night[13]="                                        "
	ascii_icon_few_clouds_night[14]="                                        "
	ascii_icon_few_clouds_night[15]="                                        "
	
	ascii_icon_cloudy[0]="                                        "
	ascii_icon_cloudy[1]="                                        "
	ascii_icon_cloudy[2]="${foreground_color_light_gray}            .,,,,.                      ${foreground_color_white}"
	ascii_icon_cloudy[3]="${foreground_color_light_gray}         .'oo''''''',.                  ${foreground_color_white}"
	ascii_icon_cloudy[4]="${foreground_color_light_gray}       .oo,.       ..,'   ,,',.         ${foreground_color_white}"
	ascii_icon_cloudy[5]="${foreground_color_light_gray}      .*'              ,,,,,''oo.       ${foreground_color_white}"
	ascii_icon_cloudy[6]="${foreground_color_light_gray}      ,o                       ,o,      ${foreground_color_white}"
	ascii_icon_cloudy[7]="${foreground_color_light_gray}  ,,,,',                        .,''',  ${foreground_color_white}"
	ascii_icon_cloudy[8]="${foreground_color_light_gray},oo,                                ,oo,${foreground_color_white}"
	ascii_icon_cloudy[9]="${foreground_color_light_gray}o*,                                  ,**${foreground_color_white}"
	ascii_icon_cloudy[10]="${foreground_color_light_gray}o*'                                  '*o${foreground_color_white}"
	ascii_icon_cloudy[11]="${foreground_color_light_gray}.o*o,,............................,,o*o.${foreground_color_white}"
	ascii_icon_cloudy[12]="${foreground_color_light_gray}  'o******',o**********o,'**********o'  ${foreground_color_white}"
	ascii_icon_cloudy[13]="                                        "
	ascii_icon_cloudy[14]="                                        "
	ascii_icon_cloudy[15]="                                        "
	
	ascii_icon_rain[0]="${foreground_color_light_gray}            .,,,,.                      ${foreground_color_white}"
	ascii_icon_rain[1]="${foreground_color_light_gray}         .'oo''''''',.                  ${foreground_color_white}"
	ascii_icon_rain[2]="${foreground_color_light_gray}       .oo,.       ..,'   ,,',.         ${foreground_color_white}"
	ascii_icon_rain[3]="${foreground_color_light_gray}      .*'              ,,,,,''oo.       ${foreground_color_white}"
	ascii_icon_rain[4]="${foreground_color_light_gray}      ,o                       ,o,      ${foreground_color_white}"
	ascii_icon_rain[5]="${foreground_color_light_gray}  ,,,,',                        .,''',  ${foreground_color_white}"
	ascii_icon_rain[6]="${foreground_color_light_gray},oo,                                ,oo,${foreground_color_white}"
	ascii_icon_rain[7]="${foreground_color_light_gray}o*,                                  ,**${foreground_color_white}"
	ascii_icon_rain[8]="${foreground_color_light_gray}o*'                                  '*o${foreground_color_white}"
	ascii_icon_rain[9]="${foreground_color_light_gray}.o*o,,............................,,o*o.${foreground_color_white}"
	ascii_icon_rain[10]="${foreground_color_light_gray}  'o******',o**********o,'**********o'  ${foreground_color_white}"
	ascii_icon_rain[11]="${foreground_color_blue}         ,           ,           ,      ${foreground_color_white}"
	ascii_icon_rain[12]="${foreground_color_blue}     .,o*'       .,o*'       .,o*'      ${foreground_color_white}"
	ascii_icon_rain[13]="${foreground_color_blue}   '*****'     '*****'     '*****'      ${foreground_color_white}"
	ascii_icon_rain[14]="${foreground_color_blue}   o*****.     o*****.     o*****.      ${foreground_color_white}"
	ascii_icon_rain[15]="${foreground_color_blue}    o**o,       o**o,       o**o,       ${foreground_color_white}"
	
	ascii_icon_clear_rainy_day[0]="                                        "
	ascii_icon_clear_rainy_day[1]="${foreground_color_light_gray}            .,,,,.         ${foreground_color_yellow}      |      ${foreground_color_white}"
	ascii_icon_clear_rainy_day[2]="${foreground_color_light_gray}         .'oo''''''',.     ${foreground_color_yellow}  \   |   /  ${foreground_color_white}"
	ascii_icon_clear_rainy_day[3]="${foreground_color_light_gray}       .oo,.       ..,'   ,${foreground_color_yellow}   \     /   ${foreground_color_white}"
	ascii_icon_clear_rainy_day[4]="${foreground_color_light_gray}      .*'              ,,,,${foreground_color_yellow}    ,d8b,    ${foreground_color_white}"
	ascii_icon_clear_rainy_day[5]="${foreground_color_light_gray}      ,o                   ${foreground_color_yellow}--- 88888 ---${foreground_color_white}"
	ascii_icon_clear_rainy_day[6]="${foreground_color_light_gray}  ,,,,',                   ${foreground_color_yellow}    '98P'    ${foreground_color_white}"
	ascii_icon_clear_rainy_day[7]="${foreground_color_light_gray},oo,                       ${foreground_color_yellow}   /     \   ${foreground_color_white}"
	ascii_icon_clear_rainy_day[8]="${foreground_color_light_gray}o*,                        ${foreground_color_yellow}  /   |   \  ${foreground_color_white}"
	ascii_icon_clear_rainy_day[9]="${foreground_color_light_gray}o*'       ${foreground_color_blue}     ,           ${foreground_color_yellow}  ${foreground_color_blue},   ${foreground_color_yellow}|   ${foreground_color_light_gray}'*o${foreground_color_white}"
	ascii_icon_clear_rainy_day[10]="${foreground_color_light_gray}.o*o,,.  ${foreground_color_blue}  .,o*'  ${foreground_color_light_gray}...  ${foreground_color_blue}  .,o*'   ${foreground_color_light_gray}.,,o*o.${foreground_color_white}"
	ascii_icon_clear_rainy_day[11]="${foreground_color_light_gray}  'o***  ${foreground_color_blue}'*****'  ${foreground_color_light_gray}***  ${foreground_color_blue}'*****'   ${foreground_color_light_gray}***o'  ${foreground_color_white}"
	ascii_icon_clear_rainy_day[12]="${foreground_color_light_gray}         ${foreground_color_blue}o*****.       ${foreground_color_blue}o*****.          ${foreground_color_white}"
	ascii_icon_clear_rainy_day[13]="${foreground_color_light_gray}         ${foreground_color_blue} o**o,        ${foreground_color_blue} o**o,           ${foreground_color_white}"
	ascii_icon_clear_rainy_day[14]="                                        "
	ascii_icon_clear_rainy_day[15]="                                        "
	
	ascii_icon_clear_rainy_night[0]="                                        "
	ascii_icon_clear_rainy_night[1]="${foreground_color_light_gray}            .,,,,.         ${foreground_color_yellow}       ____  ${foreground_color_white}"
	ascii_icon_clear_rainy_night[2]="${foreground_color_light_gray}         .'oo''''''',.     ${foreground_color_yellow}    ,''8L,-\`.${foreground_color_white}"
	ascii_icon_clear_rainy_night[3]="${foreground_color_light_gray}       .oo,.       ..,'   ,${foreground_color_yellow}  ,'88,'     ${foreground_color_white}"
	ascii_icon_clear_rainy_night[4]="${foreground_color_light_gray}      .*'              ,,,,${foreground_color_yellow} /888/       ${foreground_color_white}"
	ascii_icon_clear_rainy_night[5]="${foreground_color_light_gray}      ,o                   ${foreground_color_yellow}:888:        ${foreground_color_white}"
	ascii_icon_clear_rainy_night[6]="${foreground_color_light_gray}  ,,,,',                   ${foreground_color_yellow}:888:        ${foreground_color_white}"
	ascii_icon_clear_rainy_night[7]="${foreground_color_light_gray},oo,                       ${foreground_color_yellow} \888\       ${foreground_color_white}"
	ascii_icon_clear_rainy_night[8]="${foreground_color_light_gray}o*,                        ${foreground_color_yellow}  \`.88\`._    ${foreground_color_white}"
	ascii_icon_clear_rainy_night[9]="${foreground_color_light_gray}o*'       ${foreground_color_blue}     ,           ${foreground_color_yellow}    \`.9LL\`-.'${foreground_color_white}"
	ascii_icon_clear_rainy_night[10]="${foreground_color_light_gray}.o*o,,.  ${foreground_color_blue}  .,o*'  ${foreground_color_light_gray}...  ${foreground_color_blue}  .,o*'   ${foreground_color_light_gray}.,,o*o.${foreground_color_white}"
	ascii_icon_clear_rainy_night[11]="${foreground_color_light_gray}  'o***  ${foreground_color_blue}'*****'  ${foreground_color_light_gray}***  ${foreground_color_blue}'*****'   ${foreground_color_light_gray}***o'  ${foreground_color_white}"
	ascii_icon_clear_rainy_night[12]="${foreground_color_blue}         o*****.       o*****.          ${foreground_color_white}"
	ascii_icon_clear_rainy_night[13]="${foreground_color_blue}          o**o,         o**o,           ${foreground_color_white}"
	ascii_icon_clear_rainy_night[14]="                                        "
	ascii_icon_clear_rainy_night[15]="                                        "
	
	ascii_icon_thunderstorm[0]="${foreground_color_dark_gray}            .,,,,.                      ${foreground_color_white}"
	ascii_icon_thunderstorm[1]="${foreground_color_dark_gray}         .'oo''''''',.                  ${foreground_color_white}"
	ascii_icon_thunderstorm[2]="${foreground_color_dark_gray}       .oo,.       ..,'   ,,',.         ${foreground_color_white}"
	ascii_icon_thunderstorm[3]="${foreground_color_dark_gray}      .*'              ,,,,,''oo.       ${foreground_color_white}"
	ascii_icon_thunderstorm[4]="${foreground_color_dark_gray}      ,o                       ,o,      ${foreground_color_white}"
	ascii_icon_thunderstorm[5]="${foreground_color_dark_gray}  ,,,,',                        .,''',  ${foreground_color_white}"
	ascii_icon_thunderstorm[6]="${foreground_color_dark_gray},oo,                                ,oo,${foreground_color_white}"
	ascii_icon_thunderstorm[7]="${foreground_color_dark_gray}o*,                                  ,**${foreground_color_white}"
	ascii_icon_thunderstorm[8]="${foreground_color_dark_gray}o*'        ${foreground_color_white} / '/         / '/  ${foreground_color_dark_gray}      '*o${foreground_color_white}"
	ascii_icon_thunderstorm[9]="${foreground_color_dark_gray}.o*o,,...  ${foreground_color_white}/_ /_  ${foreground_color_dark_gray}....  ${foreground_color_white}/_ /_  ${foreground_color_dark_gray}...,,o*o.${foreground_color_white}"
	ascii_icon_thunderstorm[10]="${foreground_color_dark_gray}  'o***** ${foreground_color_white}  / /' ${foreground_color_dark_gray} **** ${foreground_color_white}  / /' ${foreground_color_dark_gray} *****o'  ${foreground_color_white}"
	ascii_icon_thunderstorm[11]="${foreground_color_white}           /_/_         /_/_            "
	ascii_icon_thunderstorm[12]="${foreground_color_white}            //'          //'            "
	ascii_icon_thunderstorm[13]="${foreground_color_white}           //           //              "
	ascii_icon_thunderstorm[14]="${foreground_color_white}          /            /                "
	ascii_icon_thunderstorm[15]="${foreground_color_white}                                        "
	
	ascii_icon_snow[0]="${foreground_color_light_gray}            .,,,,.                      ${foreground_color_white}"
	ascii_icon_snow[1]="${foreground_color_light_gray}         .'oo''''''',.                  ${foreground_color_white}"
	ascii_icon_snow[2]="${foreground_color_light_gray}       .oo,.       ..,'   ,,',.         ${foreground_color_white}"
	ascii_icon_snow[3]="${foreground_color_light_gray}      .*'              ,,,,,''oo.       ${foreground_color_white}"
	ascii_icon_snow[4]="${foreground_color_light_gray}      ,o                       ,o,      ${foreground_color_white}"
	ascii_icon_snow[5]="${foreground_color_light_gray}  ,,,,',                        .,''',  ${foreground_color_white}"
	ascii_icon_snow[6]="${foreground_color_light_gray},oo,                                ,oo,${foreground_color_white}"
	ascii_icon_snow[7]="${foreground_color_light_gray}o*,                                  ,**${foreground_color_white}"
	ascii_icon_snow[8]="${foreground_color_light_gray}o*'                                  '*o${foreground_color_white}"
	ascii_icon_snow[9]="${foreground_color_light_gray}.o*o,,............................,,o*o.${foreground_color_white}"
	ascii_icon_snow[10]="${foreground_color_light_gray}  'o******',o**********o,'**********o'  ${foreground_color_white}"
	ascii_icon_snow[11]="${foreground_color_white}       __/\__              __/\__       "
	ascii_icon_snow[12]="${foreground_color_white}       \_\/_/    __/\__    \_\/_/       "
	ascii_icon_snow[13]="${foreground_color_white}       /_/\_\    \_\/_/    /_/\_\       "
	ascii_icon_snow[14]="${foreground_color_white}         \/      /_/\_\      \/         "
	ascii_icon_snow[15]="${foreground_color_white}                   \/                   "
	
	ascii_icon_mist[0]="${foreground_color_light_gray}      .''o****o',.                      ${foreground_color_white}"
	ascii_icon_mist[1]="${foreground_color_light_gray}    ,o*************'.             ..    ${foreground_color_white}"
	ascii_icon_mist[2]="${foreground_color_light_gray}   o***o',,...,'o****o',.     .,'o**o   ${foreground_color_white}"
	ascii_icon_mist[3]="${foreground_color_light_gray}   .''.           ,o***************o.   ${foreground_color_white}"
	ascii_icon_mist[4]="${foreground_color_light_gray}                    ..,'o*****oo',.     ${foreground_color_white}"
	ascii_icon_mist[5]="${foreground_color_light_gray}        .,,'',,.                        ${foreground_color_white}"
	ascii_icon_mist[6]="${foreground_color_light_gray}    .'o**********o',                    ${foreground_color_white}"
	ascii_icon_mist[7]="${foreground_color_light_gray}   o*****o',,''o*****o'.       .,o**o   ${foreground_color_white}"
	ascii_icon_mist[8]="${foreground_color_light_gray}   ,'',.         .'o****o'''''o****o,   ${foreground_color_white}"
	ascii_icon_mist[9]="${foreground_color_light_gray}                    .,,'o*****oo',.     ${foreground_color_white}"
	ascii_icon_mist[10]="${foreground_color_light_gray}        .,,',,,.                        ${foreground_color_white}"
	ascii_icon_mist[11]="${foreground_color_light_gray}    .'o**********o',                    ${foreground_color_white}"
	ascii_icon_mist[12]="${foreground_color_light_gray}   o*****o',,''o*****o'.       .,o**o   ${foreground_color_white}"
	ascii_icon_mist[13]="${foreground_color_light_gray}   ,'',.         .'o****o'''''o****o,   ${foreground_color_white}"
	ascii_icon_mist[14]="${foreground_color_light_gray}                    .'o**********'.     ${foreground_color_white}"
	ascii_icon_mist[15]="${foreground_color_light_gray}                       .'o***o',.       ${foreground_color_white}"
	
	read -r unit_type < "${script_directory}/unit_type"
	
	if [[ "${unit_type}" != "metric" && "${unit_type}" != "imperial" ]]
	then
		unit_type="metric"
		
		printf "${unit_type}" > "${script_directory}/unit_type"
	fi
	
	if [[ "${unit_type}" == "metric" ]]
	then
		temperature_unit="C"
		wind_unit="km/h"
	else
		temperature_unit="F"
		wind_unit="mph"
	fi
	
	# Read OpenWeatherMap API key
	if [[ "${api_key}" == "" ]]
	then
		api_key=$(grep "^[0-9A-Za-z]\+$" \
"${script_directory}/openweathermap.key")
	fi
}
