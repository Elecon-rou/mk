#!/bin/sh

echo CLEAN mk
echo CLEAN lib9/lib9.a
rm -f mk lib9/lib.a
echo CLEAN .o
rm -f lib9/sec/*.o lib9/fmt/*.o lib9/utf/*.o lib9/bio/*.o lib9/regex/*.o lib9/*.o *.o
