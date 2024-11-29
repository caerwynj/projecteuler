BEGIN{total=0}
{n = substr($0, 0, 3) + 0; print n; total += n}
END{print "TOTAL " total}
