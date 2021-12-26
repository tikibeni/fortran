# Ajo-ohjeet

Simulaattorin saa ajettua `src`-kansiosta komennolla:

```shell
~/fortran/src$ make simulation
```

Makefile huolehtii ohjelman kääntämisestä (_compile_) ja ajamisesta kätevästi. Ajon jälkeen ohjelma
poistaa käännetyt komponentit.

Ohjelma ei tarvitse mitään syötteitä, vaan tarvittavat tiedot on kovakoodattu päätiedostoon [main.f90](../src/main.f90).

Halutessasi voit muuttaa seuraavanlaisia simulaatioparametrejä päätiedostosta:

- duration: Simulaation kesto vaiheiden lukumääränä
- arrLength: Luotavan taulukon koko, jossa yksilöt liikkuvat
- ppLength: Yksilöiden lukumäärä taulukossa
- initialInfected: Sairaiden lukumäärä simulaation alussa
- initialImmune: Immuuneiden lukumäärä simulaation alussa
- probabilityOfHealing: Parantumisen todennäköisyys prosentteina
- probabilityOfInfection: Sairastumisen todennäköisyys prosentteina

Ohjelma ajaa simulaation ja tulostaa välivaiheet tartuntatilanteesta. Formaatti on luettavissa
tiedostosta [output.dat](./output.dat).
