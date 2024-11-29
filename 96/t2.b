implement Command;
include "cmd.m";

main(argv: list of string)
{
	argv = tl argv;
	if(len argv == 0) raise "arg";
	fd := bufio->open(hd argv, Bufio->OREAD);
	while((line := fd.gets('\n')) != nil){
		if(str->prefix("solution:", line))
			solution(line);
	}
}

solution(s: string)
{
	s = s[len "solution:":];
	(n, l) := sys->tokenize(s, ";");
	for(; l != nil; l = tl l) {
		ss := hd l;
		(m, k) := sys->tokenize(ss, " ");
		
	}
}
