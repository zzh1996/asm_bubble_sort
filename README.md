# asm_bubble_sort
bubble sort in nasm assembly, COD homework

```
nasm -felf bubble.asm && gcc bubble.o -m32
gcc genrandom.c -o genrandom
./genrandom data.txt 100000
time cat data.txt | ./a.out | less
```
