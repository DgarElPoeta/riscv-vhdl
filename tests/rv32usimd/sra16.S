# See LICENSE for license details.

#*****************************************************************************
# sra16.S
#-----------------------------------------------------------------------------
#
# Test sra16 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RR_OP( 2,  sra16, 0x80008000, 0x80008000, 0x00000000 );
  TEST_RR_OP( 3,  sra16, 0xe000e000, 0x80008000, 0x00020002 );
  TEST_RR_OP( 4,  sra16, 0xff00ff00, 0x80008000, 0x00070007 );
  TEST_RR_OP( 5,  sra16, 0xffe0ffe0, 0x80008000, 0x000a000a );
  TEST_RR_OP( 6,  sra16, 0xffffffff, 0x80008000, 0x000f000f );

  TEST_RR_OP( 7,  sra16, 0x7fff7fff, 0x7fff7fff, 0x00000000 );
  TEST_RR_OP( 8,  sra16, 0x1fff1fff, 0x7fff7fff, 0x00020002 );
  TEST_RR_OP( 9,  sra16, 0x00ff00ff, 0x7fff7fff, 0x00070007 );
  TEST_RR_OP( 10, sra16, 0x001f001f, 0x7fff7fff, 0x000a000a );
  TEST_RR_OP( 11, sra16, 0x00000000, 0x7fff7fff, 0x000f000f );

  TEST_RR_OP( 12, sra16, 0xc000c000, 0xc000c000, 0x00000000 );
  TEST_RR_OP( 13, sra16, 0xf000f000, 0xc000c000, 0x00020002 );
  TEST_RR_OP( 14, sra16, 0xff80ff80, 0xc000c000, 0x00070007 );
  TEST_RR_OP( 15, sra16, 0xfff0fff0, 0xc000c000, 0x000a000a );
  TEST_RR_OP( 16, sra16, 0xffffffff, 0xc000c000, 0x000f000f );

  # Verify that shifts only use bottom three bits of 8 bit data

  TEST_RR_OP( 17, sra16, 0xc000c000, 0xc000c000, 0xfff0fff0 );
  TEST_RR_OP( 18, sra16, 0xf000f000, 0xc000c000, 0xfff2fff2 );
  TEST_RR_OP( 19, sra16, 0xff80ff80, 0xc000c000, 0xfff7fff7 );
  TEST_RR_OP( 20, sra16, 0xfff0fff0, 0xc000c000, 0xfffafffa );
  TEST_RR_OP( 21, sra16, 0xffffffff, 0xc000c000, 0xffffffff );
  
  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RR_SRC1_EQ_DEST( 22, sra16, 0xff00ff00, 0x80008000, 0x00070007 );
  TEST_RR_SRC2_EQ_DEST( 23, sra16, 0xffe0ffe0, 0x80008000, 0x000a000a );
  TEST_RR_SRC12_EQ_DEST( 24, sra16, 0xfe3efe3e, 0xf1f3f1f3 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RR_DEST_BYPASS( 25, 0, sra16, 0xff00ff00, 0x80008000, 0x00070007 );
  TEST_RR_DEST_BYPASS( 26, 1, sra16, 0xffe0ffe0, 0x80008000, 0x000a000a );
  TEST_RR_DEST_BYPASS( 27, 2, sra16, 0xffffffff, 0x80008000, 0x000f000f );

  TEST_RR_SRC12_BYPASS( 28, 0, 0, sra16, 0xff00ff00, 0x80008000, 0x00070007 );
  TEST_RR_SRC12_BYPASS( 29, 0, 1, sra16, 0xffe0ffe0, 0x80008000, 0x000a000a );
  TEST_RR_SRC12_BYPASS( 30, 0, 2, sra16, 0xffffffff, 0x80008000, 0x000f000f );
  TEST_RR_SRC12_BYPASS( 31, 1, 0, sra16, 0xff00ff00, 0x80008000, 0x00070007 );
  TEST_RR_SRC12_BYPASS( 32, 1, 1, sra16, 0xffe0ffe0, 0x80008000, 0x000a000a );
  TEST_RR_SRC12_BYPASS( 33, 2, 0, sra16, 0xffffffff, 0x80008000, 0x000f000f );

  TEST_RR_SRC21_BYPASS( 34, 0, 0, sra16, 0xff00ff00, 0x80008000, 0x00070007 );
  TEST_RR_SRC21_BYPASS( 35, 0, 1, sra16, 0xffe0ffe0, 0x80008000, 0x000a000a );
  TEST_RR_SRC21_BYPASS( 36, 0, 2, sra16, 0xffffffff, 0x80008000, 0x000f000f );
  TEST_RR_SRC21_BYPASS( 37, 1, 0, sra16, 0xff00ff00, 0x80008000, 0x00070007 );
  TEST_RR_SRC21_BYPASS( 38, 1, 1, sra16, 0xffe0ffe0, 0x80008000, 0x000a000a );
  TEST_RR_SRC21_BYPASS( 39, 2, 0, sra16, 0xffffffff, 0x80008000, 0x000f000f );

  TEST_RR_ZEROSRC1( 40, sra16, 0x00000000, 0x05050505 );
  TEST_RR_ZEROSRC2( 41, sra16, 0x80008000, 0x80008000 );
  TEST_RR_ZEROSRC12( 42, sra16, 0x00000000 );
  TEST_RR_ZERODEST( 43, sra16, 0x10101010, 0x10101010 );

  TEST_PASSFAIL

