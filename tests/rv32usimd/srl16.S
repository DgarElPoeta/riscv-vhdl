# See LICENSE for license details.

#*****************************************************************************
# srl16.S
#-----------------------------------------------------------------------------
#
# Test srl16 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  srl16, 0x80008000, 0x80008000, 0x00000000 );
  TEST_RR_OP( 3,  srl16, 0x20002000, 0x80008000, 0x00020002 );
  TEST_RR_OP( 4,  srl16, 0x01000100, 0x80008000, 0x00070007 );
  TEST_RR_OP( 5,  srl16, 0x00200020, 0x80008000, 0x000a000a );
  TEST_RR_OP( 6,  srl16, 0x00010001, 0x80008000, 0x000f000f );

  TEST_RR_OP( 7,  srl16, 0xffffffff, 0xffffffff, 0x00000000 );
  TEST_RR_OP( 8,  srl16, 0x3fff3fff, 0xffffffff, 0x00020002 );
  TEST_RR_OP( 9,  srl16, 0x01ff01ff, 0xffffffff, 0x00070007 );
  TEST_RR_OP( 10, srl16, 0x003f003f, 0xffffffff, 0x000a000a );
  TEST_RR_OP( 11, srl16, 0x00010001, 0xffffffff, 0x000f000f );

  TEST_RR_OP( 12, srl16, 0x50005000, 0x50005000, 0x00000000 );
  TEST_RR_OP( 13, srl16, 0x14001400, 0x50005000, 0x00020002 );
  TEST_RR_OP( 14, srl16, 0x00a000a0, 0x50005000, 0x00070007 );
  TEST_RR_OP( 15, srl16, 0x00140014, 0x50005000, 0x000a000a );
  TEST_RR_OP( 16, srl16, 0x00000000, 0x50005000, 0x000f000f );

  # Verify that shifts only use bottom three bits of 8 bit data

  TEST_RR_OP( 17, srl16, 0x50005000, 0x50005000, 0xfff0fff0 );
  TEST_RR_OP( 18, srl16, 0x14001400, 0x50005000, 0xfff2fff2 );
  TEST_RR_OP( 19, srl16, 0x00a000a0, 0x50005000, 0xfff7fff7 );
  TEST_RR_OP( 20, srl16, 0x00140014, 0x50005000, 0xfffafffa );
  TEST_RR_OP( 21, srl16, 0x00000000, 0x50005000, 0xffffffff );
  
  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 22, srl16, 0x01000100, 0x80008000, 0x00070007 );
  TEST_RR_SRC2_EQ_DEST( 23, srl16, 0x00200020, 0x80008000, 0x000a000a );
  TEST_RR_SRC12_EQ_DEST( 24, srl16, 0x1e3e1e3e, 0xf1f3f1f3 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 25, 0, srl16, 0x01000100, 0x80008000, 0x00070007 );
  TEST_RR_DEST_BYPASS( 26, 1, srl16, 0x00200020, 0x80008000, 0x000a000a );
  TEST_RR_DEST_BYPASS( 27, 2, srl16, 0x00010001, 0x80008000, 0x000f000f );

  TEST_RR_SRC12_BYPASS( 28, 0, 0, srl16, 0x01000100, 0x80008000, 0x00070007 );
  TEST_RR_SRC12_BYPASS( 29, 0, 1, srl16, 0x00200020, 0x80008000, 0x000a000a );
  TEST_RR_SRC12_BYPASS( 30, 0, 2, srl16, 0x00010001, 0x80008000, 0x000f000f );
  TEST_RR_SRC12_BYPASS( 31, 1, 0, srl16, 0x01000100, 0x80008000, 0x00070007 );
  TEST_RR_SRC12_BYPASS( 32, 1, 1, srl16, 0x00200020, 0x80008000, 0x000a000a );
  TEST_RR_SRC12_BYPASS( 33, 2, 0, srl16, 0x00010001, 0x80008000, 0x000f000f );

  TEST_RR_SRC21_BYPASS( 34, 0, 0, srl16, 0x01000100, 0x80008000, 0x00070007 );
  TEST_RR_SRC21_BYPASS( 35, 0, 1, srl16, 0x00200020, 0x80008000, 0x000a000a );
  TEST_RR_SRC21_BYPASS( 36, 0, 2, srl16, 0x00010001, 0x80008000, 0x000f000f );
  TEST_RR_SRC21_BYPASS( 37, 1, 0, srl16, 0x01000100, 0x80008000, 0x00070007 );
  TEST_RR_SRC21_BYPASS( 38, 1, 1, srl16, 0x00200020, 0x80008000, 0x000a000a );
  TEST_RR_SRC21_BYPASS( 39, 2, 0, srl16, 0x00010001, 0x80008000, 0x000f000f );

  TEST_RR_ZEROSRC1( 40, srl16, 0x00000000, 0x05050505 );
  TEST_RR_ZEROSRC2( 41, srl16, 0x80008000, 0x80008000 );
  TEST_RR_ZEROSRC12( 42, srl16, 0x00000000 );
  TEST_RR_ZERODEST( 43, srl16, 0x10101010, 0x10101010 );

  TEST_PASSFAIL

