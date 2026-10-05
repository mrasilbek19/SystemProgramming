MAIN    START   0
        JSUB    INPUT
        JSUB    PROCESS
        JSUB    OUTPUT

HALT    J       HALT


INPUT   CLEAR   X

INLOOP  TD      INDEV
        JEQ     INLOOP
        CLEAR   A
        RD      INDEV
        STCH    BUFFER,X
        TIX     N23
        JLT     INLOOP

        RSUB

PROCESS CLEAR   X


CONVERT STX     POS

        CLEAR   A
        LDCH    BUFFER,X
        SUB     ASCII0
        MUL     TEN
        STA     TEMP

        LDA     ONE
        ADDR    A,X

        CLEAR   A
        LDCH    BUFFER,X
        SUB     ASCII0
        ADD     TEMP
        STA     VALUE

        LDX     POS
        LDA     VALUE
        STA     BUFFER,X

        LDA     THREE
        ADDR    A,X

        LDT     N24
        COMPR   X,T
        JLT     CONVERT


        CLEAR   X

        LDA     HUNDRED
        STA     MINDIFF


PAIRLP  STX     POS

        LDA     BUFFER,X
        STA     VALUE1

        LDA     THREE
        ADDR    A,X

        LDA     BUFFER,X
        STA     VALUE2

        LDA     VALUE1
        SUB     VALUE2
        COMP    ZERO
        JLT     MAKEPOS


CHECK   COMP    MINDIFF
        JLT     UPDATE
        J       NEXT


MAKEPOS MUL     NEGONE
        J       CHECK


UPDATE  STA     MINDIFF

        LDA     VALUE1
        STA     RESULT1

        LDA     VALUE2
        STA     RESULT2


NEXT    LDX     POS

        LDA     THREE
        ADDR    A,X

        LDT     N21
        COMPR   X,T
        JLT     PAIRLP

        RSUB

OUTPUT  LDA     RESULT1
        DIV     TEN
        ADD     ASCII0
WAIT1   TD      OUTDEV
        JEQ     WAIT1
        WD      OUTDEV


        LDA     RESULT1
        DIV     TEN
        MUL     TEN
        STA     TEMP

        LDA     RESULT1
        SUB     TEMP
        ADD     ASCII0
WAIT2   TD      OUTDEV
        JEQ     WAIT2
        WD      OUTDEV


        LDA     SPACE
WAIT3   TD      OUTDEV
        JEQ     WAIT3
        WD      OUTDEV


        LDA     RESULT2
        DIV     TEN
        ADD     ASCII0
WAIT4   TD      OUTDEV
        JEQ     WAIT4
        WD      OUTDEV


        LDA     RESULT2
        DIV     TEN
        MUL     TEN
        STA     TEMP

        LDA     RESULT2
        SUB     TEMP
        ADD     ASCII0
WAIT5   TD      OUTDEV
        JEQ     WAIT5
        WD      OUTDEV

        RSUB


INDEV   BYTE    X'03'
OUTDEV  BYTE    X'04'

ASCII0  WORD    48
SPACE   WORD    32

ZERO    WORD    0
ONE     WORD    1
THREE   WORD    3
TEN     WORD    10

N21     WORD    21
N23     WORD    23
N24     WORD    24

HUNDRED WORD    100
NEGONE  WORD    -1

POS     RESW    1
TEMP    RESW    1
VALUE   RESW    1

VALUE1  RESW    1
VALUE2  RESW    1

MINDIFF RESW    1
RESULT1 RESW    1
RESULT2 RESW    1

BUFFER  RESB    24

        END     MAIN
