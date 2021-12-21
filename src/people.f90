! Moduuli yksilöiden hallintaa varten
module people
    ! Alustus:
    ! - Henkilöön liittyy id, x- ja y-koordinaatit sekä tila
    implicit none
    type :: walker
        integer :: id, xPosition, yPosition, state
    end type walker
contains

    ! Uuden yksilön luonti
    type (walker) function create(id, arrLength, ppLength, initialInfected, initialImmune)
        ! Alustus:
        ! - Parametrina yksilön ID
        ! - x- ja y-koordinaatit
        ! - Yksilön tila (0=terve, 1=sairas, 2=immuuni)
        ! - Arvottava ruutu
        implicit none
        integer, intent(in) :: id, arrLength, ppLength, initialInfected, initialImmune
        integer :: xPosition, yPosition, state
        real :: cell

        ! Oletusarvoisesti terve
        state = 0

        call random_number(cell)
        xPosition = nint(arrLength * cell)

        call random_number(cell)
        yPosition = nint(arrLength * cell)

        ! Jos tarpeeksi sairaita ei ole luotu, luodaan sairaana
        if (id < initialInfected + 1) then
            state = 1
        end if

        ! Jos tarpeeksi immuuneja ei ole luotu, luodaan immuunina
        if (id > ppLength - initialImmune) then
            state = 2
        end if

        create = walker(id, xPosition, yPosition, state)
    end function create

    ! Yksilön kävelyttäminen
    type (walker) function walk(individual, arrLength)
        ! Alustus:
        ! - Parametrina yksilö ja taulukon koko
        ! - Varaus suunnalle ja satunnaisluvulle
        implicit none
        type (walker), intent(in) :: individual
        integer, intent(in) :: arrLength
        integer :: direction
        real :: random

        ! Yksilön tiedot kävelyä varten
        walk%xPosition = individual%xPosition
        walk%yPosition = individual%yPosition
        walk%state = individual%state
        walk%id = individual%id

        ! Suunnan arpominen (0=oikea, 1=alas, 2=vasen, 3=ylös)
        call random_number(random)
        direction = nint(3 * random)

        ! Suunnanmukainen kävely
        if (direction == 0) then
            walk%xPosition = walk%xPosition + 1
        else if (direction == 1) then
            walk%yPosition = walk%yPosition + 1
        else if (direction == 2) then
            walk%xPosition = walk%xPosition - 1
        else
            walk%yPosition = walk%yPosition - 1
        end if

        ! Mikäli ollaan liikuttu reunojen yli, siirretään toiselle puolelle taulukkoa.
        if (walk%xPosition < 0) then
            walk%xPosition = arrLength
        else if (walk%yPosition < 0) then
            walk%yPosition = arrLength
        else if (walk%xPosition > arrLength) then
            walk%xPosition = 0
        else if (walk%yPosition > arrLength) then
            walk%yPosition = 0
        end if
    end function walk

    ! Yksilön tartuttaminen
    type (walker) function infect(individual, peopleArray, probabilityOfInfection, arrLength)
        ! Alustus:
        ! - Parametreinä yksilö, henkilötaulukko, tartuntatodennäköisyys
        ! - Varaus todennäköisyydelle, yksilön id:lle, tartuttajalle ja satunnaisuudelle
        implicit none
        integer, intent(in) :: probabilityOfInfection, arrLength
        type (walker), intent(in) :: peopleArray(arrLength)
        type (walker), intent(in) :: individual
        type (walker) :: potentialZombie
        integer :: probability, id
        real :: random

        ! Arvotaan satunnaistodennäköisyys
        call random_number(random)
        probability = nint(100 * random)

        ! Haetaan yksilötiedot
        infect%id = individual%id
        infect%state = individual%state
        infect%xPosition = individual%xPosition
        infect%yPosition = individual%yPosition

        ! Mikäli tarkasteltava henkilö ei ole immuuni tai sairas, tarkistetaan yksilön sijainti muihin nähden
        ! - Jos ollaan samassa ruudussa sairaan kanssa, ollaan tartuntaetäisyydellä
        ! - Jos ollaan tartuntaetäisyydellä, lasketaan saako yksilö tartunnan:
        ! -> Jos arvottu todennäköisyys on pienempi kuin tartunnan todennäköisyys, yksilö saa tartunnan
        if (infect%state == 0) then
            do id = 1, arrLength
                potentialZombie = peopleArray(id)
                if (potentialZombie%xPosition == infect%xPosition .and. potentialZombie%yPosition == infect%yPosition) then
                    if (potentialZombie%state == 1) then
                        if (probability < probabilityOfInfection) then
                            infect%state = 1
                        end if
                        exit
                    end if
                end if
            end do
        end if
    end function infect

    ! Yksilön parantaminen
    type (walker) function heal(individual, probabilityOfHealing)
        ! Alustus:
        ! - Parametreinä yksilö ja parannustodennäköisyys
        ! - Varaus todennäköisyydelle ja satunnaisluvulle
        implicit none
        integer, intent(in) :: probabilityOfHealing
        type (walker), intent(in) :: individual
        integer :: probability
        real :: random

        ! Alustetaan lokaalit muuttujat jotta siirtyy seuraavalle tyypille
        heal%xPosition = individual%xPosition
        heal%yPosition = individual%yPosition
        heal%state = individual%state
        heal%id = individual%id

        ! Arvotaan satunnaistodennäköisyys
        call random_number(random)
        probability = nint(100 * random)

        ! Mikäli parannusprosentti voittaa satunnaistodennäköisyyden ja yksilö on sairas, parannetaan yksilö
        if (probability < probabilityOfHealing .and. heal%state == 1) then
            heal%state = 2
        end if
    end function heal
end module people
