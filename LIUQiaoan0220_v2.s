#Sort all 600 of integers in array v.
#v,n saved in a0,a1. n=600
# This version use middle value as pivot
.data
v:   .4byte 05,07,02,09,01,04,03,06,08,00
     .4byte 25,27,22,29,21,24,23,26,28,20
     .4byte 35,37,32,39,31,34,33,36,38,30
     .4byte 55,57,52,59,51,54,53,56,58,50
     .4byte 145,147,142,149,141,144,143,146,148,140
     .4byte 65,67,62,69,61,64,63,66,68,60
     .4byte 265,267,262,269,261,264,263,266,268,260
     .4byte 75,77,72,79,71,74,73,76,78,70
     .4byte 85,87,82,89,81,84,83,86,88,80
     .4byte 95,97,92,99,91,94,93,96,98,90
     .4byte 105,107,102,109,101,104,103,106,108,100
     .4byte 115,117,112,119,111,114,113,116,118,110
     .4byte 125,127,122,129,121,124,123,126,128,120
     .4byte 355,357,352,359,351,354,353,356,358,350
     .4byte 135,137,132,139,131,134,133,136,138,130
     .4byte 155,157,152,159,151,154,153,156,158,150
     .4byte 165,167,162,169,161,164,163,166,168,160
     .4byte 185,187,182,189,181,184,183,186,188,180
     .4byte 195,197,192,199,191,194,193,196,198,190
     .4byte 205,207,202,209,201,204,203,206,208,200
     .4byte 215,227,212,219,211,214,213,216,218,210
     .4byte 225,227,222,229,221,224,223,226,228,220
     .4byte 45,47,42,49,41,44,43,46,48,40
     .4byte 235,237,232,239,231,234,233,236,238,230
     .4byte 245,247,242,249,241,244,243,246,248,240
     .4byte 495,497,492,499,491,494,493,496,498,490
     .4byte 255,257,252,259,251,254,253,256,258,250
     .4byte 275,277,272,279,271,274,273,276,278,270
     .4byte 285,287,282,289,281,284,283,286,288,280
     .4byte 295,297,292,299,291,294,293,296,298,290
     .4byte 305,307,302,309,301,304,303,306,308,300
     .4byte 315,317,312,319,311,314,313,316,318,310
     .4byte 325,327,322,329,321,324,323,326,328,320
     .4byte 175,177,172,179,171,174,173,176,178,170
     .4byte 335,337,332,339,331,334,333,336,338,330
     .4byte 345,347,342,349,341,344,343,346,348,340
     .4byte 365,367,362,369,361,364,363,366,368,360
     .4byte 375,367,372,379,371,374,373,376,378,370
     .4byte 385,387,382,389,381,384,383,386,388,380
     .4byte 395,397,392,399,391,394,393,396,398,390
     .4byte 405,407,402,409,401,404,403,406,408,400
     .4byte 415,417,412,419,411,414,413,416,418,410
     .4byte 425,427,422,429,421,424,423,426,428,420
     .4byte 435,437,432,439,431,434,433,436,438,430
     .4byte 465,467,462,469,461,464,463,466,468,460
     .4byte 535,537,532,539,531,534,533,536,538,530
     .4byte 475,467,472,479,471,474,473,476,478,470
     .4byte 485,487,482,489,481,484,483,486,488,480
     .4byte 505,507,502,509,501,504,503,506,508,500
     .4byte 515,517,512,519,511,514,513,516,518,510
     .4byte 525,527,522,529,521,524,523,526,528,520
     .4byte 15,17,12,19,11,14,13,16,18,10
     .4byte 545,547,542,549,541,544,543,546,548,540
     .4byte 555,557,552,559,551,554,553,556,558,550
     .4byte 565,567,562,569,561,564,563,566,568,560
     .4byte 575,567,572,579,571,574,573,576,578,570
     .4byte 445,447,442,449,441,444,443,446,448,440
     .4byte 455,457,452,459,451,454,453,456,458,450
     .4byte 585,587,582,589,581,584,583,586,588,580
     .4byte 595,597,592,599,591,594,593,596,598,590     

.text

    la a0, v                    # use a0 to store array v
    addi a1, x0, 600                # size of array v
    addi a2, x0, 0                  # low = 0
    addi a3, x0, 599                # high = 599
    jal ra, quicksort
    jal x0, Exit

quicksort:
    bge a2, a3, quicksort_exit  # if (low >= high) return;

    addi sp, sp, -16            # save stuffs in the stack
    sw ra, 0(sp)                 
    sw s10, 4(sp)               # s10 is low at upper level
    sw s11, 8(sp)               # s11 is high at upper level
    sw s9, 12(sp)               # s9 is mid at upper level

    mv s10, a2                  # s10 <- low
    mv s11, a3                  # s11 <- high

    jal ra, divide              # call divide 

    mv s9, a4

    # Now s9 is mid, s10 is low, s11 is high. We need to recursively call quicksort for left and right sub-array.
    addi a3, s9, -1             # for left part, high_left = mid-1
    mv a2, s10                  # low
    jal ra, quicksort           # quicksort(low,mid-1)

    addi a2, s9, 1              # for right part, low_right = mid+1    
    mv a3, s11                  # high
    jal ra, quicksort

    lw ra, 0(sp)                # load stuffs back into registers
    lw s10, 4(sp)
    lw s11, 8(sp)
    lw s9, 12(sp)
    addi sp, sp, 16              


quicksort_exit:
    ret

divide:
    addi sp, sp, -12            # store stuffs into stack
    sw ra, 0(sp)
    sw s10, 4(sp)
    sw s11, 8(sp)

    slli t0, s10, 2             # low*4                   
    add t0, t0, a0              # k = a+low*4

    mv t1, t0                   # t1 = a+low*4
    lw t0, 0(t0)                # k = a[low];


    slli t2, s11, 2             # t2 = high*4

    add t5, s10, s11              # swap(a[low],a[(low+high)/2])
    srai t5, t5, 1
    slli t5, t5, 2
    add t5, t5, a0
    lw t6, 0(t5)
    sw t0, 0(t5)
    # sw t6, 0(t1)
    mv t0, t6

    add t2, t2, a0              # t2 = a+high*4

LOOP1:
    bge t1, t2, outerloopexit      # if (low < high)
    lw t3, 0(t2)                # t3 = a[high]
    blt t3, t0, loop1_exit           # a[high]>=k
    addi t2, t2, -4             # --high;
    jal x0, LOOP1
loop1_exit:
    bge t1, t2, outerloopexit
    sw t3, 0(t1)                # a[low] = a[high]
    addi t1, t1, 4              # low = low+1
    addi s10, s10, 1            # low = low+1
LOOP2:
    bge t1, t2, outerloopexit      # if (low < high)
    lw t4, 0(t1)                # t4 = a[low]
    blt t0, t4, loop2_exit
    addi t1, t1, 4
    addi s10, s10, 1
    jal x0, LOOP2
loop2_exit:
    bge t1, t2, outerloopexit
    sw t4, 0(t2)
    addi t2, t2, -4
    bne t1, t2, LOOP1
    
outerloopexit:
    mv a4, s10
    sw t0, 0(t2)

    lw ra, 0(sp)
    lw s10, 4(sp)
    lw s11, 8(sp)
    addi sp, sp, 12
    ret

Exit:
    ecall