! Pääluokka
program main
    use people
    use functions
    ! Alustus:
    ! - Ihmismuuttujat (henkilötyyppi ja varaus henkilötaulukolle)
    ! - Taulukon koko, simulaation kesto, henkilöiden lkm, sairaiden lkm, immuuneiden lkm
    ! - Todennäköisyydet parantumiselle ja sairastumiselle
    ! - Luuppimuuttujat
    implicit none
    type (walker) :: individual
    type (walker), allocatable :: peopleArray(:)
    integer :: arrLength, duration, ppLength, initialInfected, initialImmune
    integer :: probabilityOfHealing, probabilityOfInfection, id, step

    ! Asetetaan halutut simulaatioarvot ja rakennetaan taulukko
    duration = 25
    arrLength = 100
    ppLength = 1000
    initialInfected = 100
    initialImmune = 0
    probabilityOfHealing = 2
    probabilityOfInfection = 38

    ! Rakennetaan taulukko annetuista arvoista
    peopleArray = buildArray(ppLength)

    ! Luodaan koehenkilöt taulukkoon
    do id = 1, ppLength
        individual = create(id, arrLength, ppLength, initialInfected, initialImmune)
        peopleArray(id) = individual
    end do

    print *, "Number of individuals in the simulation:"
    print "(i4,a1)", ppLength
    print *, ""

    ! Ajetaan simulaatiota luupissa viemällä koehenkilöt lenkille ja tulostetaan vaiheet
    do step = 1, duration
        call makeThemWalk(peopleArray, ppLength, arrLength, probabilityOfHealing, probabilityOfInfection)
        call printStatus(ppLength, peopleArray, step)
    end do
end program main
