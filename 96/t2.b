implement Command;
include "cmd.m";

main(argv: list of string)
{
	a: array of array of int;
	i, j : int = 0;
	line: string;

	argv = tl argv;
	if(len argv == 0) raise "arg";
	fd := bufio->open(hd argv + ".out", Bufio->OREAD);
	while((line = fd.gets('\n')) != nil){
		if(str->prefix("solution:", line))
			a = solution(line);
	}
	fd = bufio->open(hd argv, Bufio->OREAD);
	while((line = fd.gets('\n')) != nil){
		for (j = 0; j < 9; j++) 
			if(line[j] != '0')
				a[i][j] = line[j];
		i++;
	}
	print_sol(a);
}

solution(s: string): array of array of int
{
	a := array[9] of {* => array[9] of {* => '0'}};
	i, j, k, x: int;
	s = s[len "solution:":];
	(n, l) := sys->tokenize(s, ";");
	for(; l != nil; l = tl l) {
		ss := hd l;
		#(m, k) := sys->tokenize(ss, " ");
		#sys->print(":%s:\n", ss);
		if(len ss == 17) {
			i = ss[2] - '0';
			j = ss[3] - '0';
			k = ss[7];
			a[i][j] = k;
		}else if (len ss == 13) {
			i = ss[2] - '0';
			j = ss[6] - '0';
			k = ss[3];
			a[i][j] = k;
		}else if (len ss == 9) {
			j = ss[2] - '0';
			k = ss[3];
			x = ss[6] - '0';
			i = x - j/3;
			a[i][j] = k;
		} #else if (len ss == 5) {
		#	print("box only %s\n", ss);
		#} else
		#	print("unknown sol str %s\n", ss);
		
	}
	return a;
}

print_sol(a: array of array of int)
{
	i, j: int;
	for (i = 0; i < 9; i++){
		for (j = 0; j < 9; j++)
			sys->print("%c", a[i][j]);
		sys->print("\n");
	}
}
