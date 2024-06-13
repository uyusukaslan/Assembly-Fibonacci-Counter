# Assembly-Fibonacci-Counter

You can run the Assembly code in Linux with:

```
nasm -f elf64 fib.s &&  ld fib.o -o fib -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2 && ./fib
```
![image](https://github.com/uyusukaslan/Assembly-Fibonacci-Counter/assets/62209561/8e13e48b-373e-4529-a19d-b9c35f5c25e4)
