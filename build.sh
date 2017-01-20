#!/bin/sh
cc=gcc
ldflags=-l9 #-static 

sec="
	sec/sha1block.c
	sec/sha1.c
	sec/sha1pickle.c
	sec/md5block.c
	sec/md5.c
	sec/md5pickle.c
"

fmt="
	fmt/dofmt.c
	fmt/fltfmt.c
	fmt/fmt.c
	fmt/fmtfd.c
	fmt/fmtfdflush.c
	fmt/fmtlocale.c
	fmtlock2.c
	fmt/fmtnull.c
	fmt/fmtprint.c
	fmt/fmtquote.c
	fmt/fmtrune.c
	fmt/fmtstr.c
	fmt/fmtvprint.c
	fmt/fprint.c
	fmt/nan64.c
	fmt/print.c
	fmt/runefmtstr.c
	fmt/runeseprint.c
	fmt/runesmprint.c
	fmt/runesnprint.c
	fmt/runesprint.c
	fmt/runevseprint.c
	fmt/runevsmprint.c
	fmt/runevsnprint.c
	fmt/seprint.c
	fmt/smprint.c
	fmt/snprint.c
	fmt/sprint.c
	fmt/strtod.c
	fmt/vfprint.c
	fmt/vseprint.c
	fmt/vsmprint.c
	fmt/vsnprint.c
	fmt/charstod.c
	fmt/pow10.c
"
utf="
	utf/rune.c
	utf/runestrcat.c
	utf/runestrchr.c
	utf/runestrcmp.c
	utf/runestrcpy.c
	utf/runestrdup.c
	utf/runestrlen.c
	utf/runestrecpy.c
	utf/runestrncat.c
	utf/runestrncmp.c
	utf/runestrncpy.c
	utf/runestrrchr.c
	utf/runestrstr.c
	utf/runetype.c
	utf/utfecpy.c
	utf/utflen.c
	utf/utfnlen.c
	utf/utfrrune.c
	utf/utfrune.c
	utf/utfutf.c
"
bio="
	bio/bbuffered.c
	bio/bfildes.c
	bio/bflush.c
	bio/bgetc.c
	bio/bgetrune.c
	bio/bgetd.c
	bio/binit.c
	bio/boffset.c
	bio/bprint.c
	bio/bputc.c
	bio/bputrune.c
	bio/brdline.c
	bio/brdstr.c
	bio/bread.c
	bio/bseek.c
	bio/bvprint.c
	bio/bwrite.c
"
regex="
	regex/regcomp.c
	regex/regerror.c
	regex/regexec.c
	regex/regsub.c
	regex/regaux.c
	regex/rregexec.c
	regex/rregsub.c
"
lib9="
	_exits.c
	_p9dialparse.c
	_p9dir.c
	announce.c
	argv0.c
	atexit.c
	atoi.c
	atol.c
	atoll.c
	atnotify.c
	await.c
	cistrcmp.c
	cistrncmp.c
	cistrstr.c
	cleanname.c
	create.c
	ctime.c
	dial.c
	dirfstat.c
	dirfwstat.c
	dirmodefmt.c
	dirread.c
	dirstat.c
	dirwstat.c
	dup.c
	encodefmt.c
	errstr.c
	exec.c
	execl.c
	exitcode.c
	fcallfmt.c
	get9root.c
	getcallerpc-386.c
	getenv.c
	getfields.c
	getnetconn.c
	getns.c
	getuser.c
	getwd.c
	jmp.c
	lrand.c
	lnrand.c
	main.c
	malloc.c
	malloctag.c
	mallocz.c
	nan.c
	needsrcquote.c
	needstack.c
	netmkaddr.c
	notify.c
	nrand.c
	nulldir.c
	open.c
	opentemp.c
	pin.c
	pipe.c
	post9p.c
	postnote.c
	qlock.c
	quote.c
	rand.c
	read9pmsg.c
	readcons.c
	readn.c
	rfork.c
	searchpath.c
	seek.c
	sendfd.c
	sleep.c
	strdup.c
	strecpy.c
	sysfatal.c
	syslog.c
	sysname.c
	time.c
	tm2sec.c
	tokenize.c
	truerand.c
	u16.c
	u32.c
	u64.c
	unsharp.c
	wait.c
	waitpid.c
	write.c
	zoneinfo.c
"
obj="arc.c archive.c bufblock.c env.c file.c graph.c job.c lex.c 
      main.c match.c mk.c parse.c recipe.c rc.c rule.c run.c sh.c 
      shell.c shprint.c symtab.c var.c varsub.c word.c unix.c"

cd lib9
for f in $sec $fmt $utf $bio $regex $lib9;
do
	echo CC $f
	$cc -DPREFIX=\"\" -I. -Isec -Ifmt -Ibio -Iregex -c $f -o $f.o || exit 1
done
echo AR lib9.a
ar rc lib9.a *.o sec/*.o fmt/*.o utf/*.o bio/*.o regex/*.o
cd ..

for f in $obj;
do
	echo CC $f
	$cc -Ilib9 -I. -c $f -o $f.o || exit 1
done
echo LD mk
$cc -Llib9 -o mk *.o $ldflags
chmod 755 mk
