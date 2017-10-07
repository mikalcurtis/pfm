set PATH=%PATH%;C:\devutils\GetGnuWin32\bin
set PATH=%PATH%;C:\unxutils\bin\usr\local\wbin
rem wget-1.12 -O \temp\all.html --post-data="nursing=50&returnfirst=ALL&sort=name&ORSMENU=Directory" http://167.193.144.247/facsearchs.asp  --save-cookies=\temp\mycookies.txt --keep-session-cookies  http://167.193.144.247
rem wget-1.12 --cookies=on --keep-session-cookies --load-cookies=\temp\mycookies.txt -O \temp\ga_1.txt http://167.193.144.247/facsearchs.asp?currentpage=1

for /F %%i in (sm_zips.txt) do (
	set OUTFILE=zip_%%i.txt
	wget-1.12 -O %OUTFILE% --post-data="nursing=50&fac_zip=%%i&returnfirst=ALL&sort=name&ORSMENU=Directory" http://167.193.144.247/facsearchs.asp
)

grep selected zip_3*.txt  | sed "s/:.*selected / /" | sed "s/records.*from the //" | sed "s/ page.*//" > record_cnts.txt
echo. > ga_data.txt
for /F "tokens=1-3* delims= " %%a in (record_cnts.txt) do ( 
	echo %%a      %%b     %%c
	sed "s/<[Bb][Rr]>/\n/g" %%a | gawk -v nrecs=%%b -v inputfile=%%a -f cleanup.awk  >> ga_data.txt
)
