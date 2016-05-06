module actual_network
  use physical_constants, only: ERG_PER_MeV
  use bl_types
  use actual_network_data
  
  implicit none

  double precision, parameter, private :: avo = 6.0221417930d23
  double precision, parameter, private :: c_light = 2.99792458d10

  double precision, parameter, private :: ev2erg  = 1.60217648740d-12
  double precision, parameter, private :: mev2erg = ev2erg*1.0d6
  double precision, parameter, private :: mev2gr  = mev2erg/c_light**2

  double precision, parameter, private :: mn = 1.67492721184d-24
  double precision, parameter, private :: mp = 1.67262163783d-24
  double precision, parameter, private :: me = 9.1093821545d-28

contains

  subroutine actual_network_init()

    implicit none
    
    integer :: i

    ! Set spec_names
    ! Set short_spec_names
    
    ebind_per_nucleon(jn)   = 0.0d0
    ebind_per_nucleon(jp)   = 0.0d0
    ebind_per_nucleon(jhe4)   = 0.0d0
    ebind_per_nucleon(jc12)   = 0.0d0
    ebind_per_nucleon(jne20)   = 0.0d0
    ebind_per_nucleon(jna23)   = 0.0d0
    ebind_per_nucleon(jmg23)   = 0.0d0
    
    aion(jn)   = 1.000000d+00
    aion(jp)   = 1.000000d+00
    aion(jhe4)   = 4.000000d+00
    aion(jc12)   = 1.200000d+01
    aion(jne20)   = 2.000000d+01
    aion(jna23)   = 2.300000d+01
    aion(jmg23)   = 2.300000d+01

    zion(jn)   = 0.000000d+00
    zion(jp)   = 1.000000d+00
    zion(jhe4)   = 2.000000d+00
    zion(jc12)   = 6.000000d+00
    zion(jne20)   = 1.000000d+01
    zion(jna23)   = 1.100000d+01
    zion(jmg23)   = 1.200000d+01
    
    do i = 1, nspec
       bion(i) = bion_per_nucleon(i) * aion(i) * ERG_PER_MeV
    end do

    ! Set the number of neutrons
    nion(:) = aion(:) - zion(:)

    ! Set the mass
    mion(:) = nion(:) * mn + zion(:) * (mp + me) - bion(:) * mev2gr

    ! Molar mass
    wion(:) = avo * mion(:)

    ! Common approximation
    wion(:) = aion(:)

    !$acc update device(aion, zion, bion, nion, mion, wion)
  end subroutine actual_network_init

  subroutine network_finalize()
    ! stub for Maestro
  end subroutine network_finalize
  
end module actual_network
