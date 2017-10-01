BEGIN{
	s = ""
	f=0
	foundstart=0
	foundrecs=0
	IGNORECASE=1
}
foundstart == 1 && /<b>.*<.b>/{
	f+=1
	n=match($0,/<b>.*<.b>/)
	if(f>1)s="|"
	printf "%s%s",s, substr($0,n+3,RLENGTH-7)
}
NF == 0 && foundstart == 1{
	if(f>0){
		if(f >= 8){
			print ""
			foundrecs += 1
		}
		if(f != 8)print FILENAME,NR,f > "/dev/stderr"
	}
	f = 0 
	s = ""
}
/If you would like to see additional information/{foundstart=1}
/facsearchs.asp/{
	foundstart=0
	if(foundrecs != nrecs)printf "ERROR: %s found %d records, expecting %d\n", inputfile, foundrecs, nrecs
}
