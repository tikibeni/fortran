! Apumoduuli
module functions
    use people
    implicit none
contains

    ! Funktio taulukon rakentamista varten
    function buildArray(amountOfPeople) result (array)
        ! Alustus:
        ! - Parametrinä henkilöiden lukumäärä
        ! - Tyhjä henkilötaulukko
        ! - Henkilöolio
        implicit none
        integer, intent(in) :: amountOfPeople
        type (walker), dimension(amountOfPeople) :: array
        type (walker) :: dummy

        ! Täytetään taulukko "dummyilla", eli tyhjillä henkilöillä
        dummy = walker(-1, -1, -1, -1)
        array = dummy
    end function buildArray

    ! Aliohjelma, joka vastaa satunnaiskävelystä
    subroutine makeThemWalk(peopleArray, ppLength, arrLength, probabilityOfHealing, probabilityOfInfection)
        implicit none
        type (walker) :: individual
        type (walker), dimension(:) :: peopleArray
        integer, intent(in) :: ppLength, arrLength, probabilityOfHealing, probabilityOfInfection
        integer :: id

        ! Luupataan kaikki henkilöt läpi:
        ! - Haetaan yksilö henkilötaulukosta
        ! - Kävelytetään yksilöä
        ! - Heitetään noppaa sairastumisen ja parantumisen osalta
        ! - Laitetaan yksilö takaisin taulukkoon
        do id = 1, ppLength
            individual = peopleArray(id)
            individual = walk(individual, arrLength)
            individual = infect(individual, peopleArray, probabilityOfInfection, ppLength)
            individual = heal(individual, probabilityOfHealing)
            peopleArray(id) = individual
        end do
    end subroutine makeThemWalk

    ! Aliohjelma tilanneseurantaa varten
    subroutine printStatus(ppLength, peopleArray, step)
        ! Alustus:
        ! - Parametreinä henkilöiden lukumäärä, henkilötaulukko sekä simulaation vaihe
        ! - Yksilömuuttuja, tilalaskurit ja luuppimuuttuja
        implicit none
        integer, intent(in) :: ppLength, step
        type (walker), dimension(:) :: peopleArray
        type (walker) :: individual
        integer :: unaffected, infected, immune, id
        unaffected = 0
        infected = 0
        immune = 0

        ! Luupataan koehenkilöt läpi ja lasketaan tilanne
        ! Järjestyksessä: terveet->sairaat->immuunit
        do id = 1, ppLength
            individual = peopleArray(id)
            if (individual%id > 0) then
                if (individual%state == 0) then
                    unaffected = unaffected + 1
                else if (individual%state == 1) then
                    infected = infected + 1
                else if (individual%state == 2) then
                    immune = immune + 1
                end if
            end if
        end do

        print *, "Step:"
        print "(i4, a1)", step
        print *, "Unaffected, Infected, Immune"
        print "(i4, a1, i4, a1, i4)", unaffected, ",", infected, ",", immune
        print *, ""
    end subroutine printStatus
end module functions
