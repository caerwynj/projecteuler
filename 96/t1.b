implement Command;
include "cmd.m";

main(argv: list of string)
{
	print("Generate exact cover for sudoku problems\n");	
	l := read_input(hd tl argv);
	#printgrid(l);
	genitem(l);
}

printgrid(l: array of array of int)
{
	for (k := 0; k < len l; k++){
		a := l[k];
		for (i:=0; i < len a; i++)
			print("%d ", a[i]);
		print("\n");
	} 
}

# for 0 <= i,j < 9, 1 <= k <= 9, x = 3*floor(i/3) + floor(j/3)
# p_ij, r_ik, c_jk, b_xk
genitem(l: array of array of int)
{
	cols := array[9] of {* => 0};
	boxes := array[9] of {* => 0};
	rows := array[9] of {* => 0};
	for (i:=0; i < len l; i++){
		a := l[i];
		m := 0;
		for (j:=0; j < len a; j++) {
			if(a[j] == 0) {
				print("p%d%d ", i,j);
			}else{
				m |= 1<<a[j];
				cols[j] |= 1<<a[j];
				b := 3 * (i/3) + (j/3);
				boxes[b] |= 1<<a[j];
			}
		}
		rows[i] = m;
		for (k:=1; k <= 9; k++) {
			if (!(m & 1<<k)) {
				print("r%d%d ", i, k);
			}
		}	
	} 
	for (j:=0; j < 9; j++) {
		for (k:=1; k <= 9; k++) {
			if (!(cols[j] & 1<<k)) {
				print("c%d%d ", j, k);
			}
		}
	}
	for (x:=0; x < 9; x++) {
		for (k:=1; k <= 9; k++) {
			if(!(boxes[x] & 1<<k)) {
				print("b%d%d ", x, k);
			}
		}
	}
	print("\n");
	for (i=0; i < 9; i++) {
		for(j=0; j < 9; j++) {
			x = 3 * (i/3) + (j/3);
			for(k:=1; k <=9; k++) {
				if(!(boxes[x] & 1<<k)  &&
					!(cols[j] & 1<<k) &&
					!(rows[i] & 1<<k))
					print("p%d%d r%d%d c%d%d b%d%d\n", i, j, i, k, j, k, x, k);
			}
		}
	}
}

read_input(filename: string): array of array of int
{
	line: string;
	l: array of array of int;
	f: ref Iobuf;
	a: array of int;
	j := 0;

	l = array[9] of array of int;
	f = bufio->open(filename, Bufio->OREAD);
	while((line = f.gets('\n')) != nil) {
		if (line == "Grid 01\n")
			continue;
		if (line == "Grid 02\n") 
			break;
		a = array[9] of int;
		for (i := 0; i < 9; i++) {
			a[i] = line[i] - '0';
		}
		l[j++] = a;
	}

	return l;
}


