# Kääntöohjeet

Ohjelman komponentit kääntyvät ajamisen yhteydessä [makefilen](makefile) ansiosta. 

Ajo-ohjeet löydät [täältä](../run/README.md).

Mikäli haluttaisiin pelkästään kääntää tiedostot, se onnistuupi komennolla

```shell
~/fortran/src$ make prog
```

Komento muodostaa moduulit `functions.mod` ja `people.mod` ja ajotiedostot `main.o`, `functions.o` ja `people.o`

Moduulit ja ajotiedostot saa siivottua kätevästi komennolla

```shell
~/fortran/src$ make clean
```
