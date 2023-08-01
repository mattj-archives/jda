DECLARE SUB BFADE (ROW!, COL!, Text$)
DECLARE SUB NewGame2 ()
DECLARE SUB EditLevel ()
DECLARE SUB QuickRef ()
DECLARE SUB PW ()
DECLARE SUB AboutJDA ()
DECLARE SUB NewGame ()
DECLARE SUB EditCustomLevel ()
DECLARE SUB MMup (BoxNum!)
DECLARE SUB MMdn (BoxNum!)
DECLARE SUB ExitGame ()
DECLARE SUB Loadgame ()
DECLARE SUB EraseBox (BoxNum!)
DECLARE SUB DrawBox (BoxNum!)
DECLARE SUB MMenu ()
CLS
DIM SHARED MenuBoxTR(4), MenuBoxB(4), MenuBoxR(4)
DIM SHARED MenOpen: MenOpen = 0: DIM SHARED M$(4): DIM SHARED M(4): FOR z = 1 TO 4: READ M$(z), M(z): NEXT
DIM SHARED M2$(3): READ M2$(1), M2$(2), M2$(3), MenuBoxTR(2), MenuBoxB(2), MenuBoxR(2)
DIM SHARED M3$(2): READ M3$(1), M3$(2), MenuBoxTR(4), MenuBoxB(4), MenuBoxR(4)
DIM SHARED MS: MS = 1: DIM SHARED MS2: MS2 = 1
DIM SHARED SavedFile$(10), NumFiles, FileName$(10), UseableFile(10)
DIM SHARED NumFile(10), FileToSave, SF$
DIM SHARED CLON, cd$, pf: CLON = 0: pf = 1
'*************FILES & CUSTOM LEVELS***************************
DIM SHARED LF, kw, sm, scm, ap, puo, PWM: kw = 0: sm = 0: scm = 0: ap = 0: puo = 0
'**************
'$DYNAMIC
DIM SHARED ObjRat, LvSpc, TempP1LSpeed, TempP1LStr, TempP2LSpeed, TempP2LStr
DIM SHARED TempNumOfDevils, temp, TempDevilSpeed(10), TempDevilMode(10), TempDevilStr(10)
DIM SHARED StartGameFlag, ST$(2), warpgameflag, wgl: warpgameflag = 0: wgl = 0
IF CLON <> 1 THEN ObjRat = 35

MMenu

' 2 (Box TR corner),  5 (Box bottom line), 14 (Box R) line

'Main menu
DATA " Play ",3," Special ",9," Exit! ",18," Help ",73
'special
DATA " Password...      ","  Custom level    "," Edit/Veiw custom ",8,6,27
'help
DATA " Instructions "," About JDA    ", 65, 5, 80

REM $STATIC
SUB AboutJDA
COLOR 0, 7
LOCATE 5, 5: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE 6, 5: PRINT "³                 Jersey Devil: Advanced version 1.0                 ³"
LOCATE 7, 5: PRINT "³                   A game by Matthew Johnson                        ³"
LOCATE 8, 5: PRINT "³                       JD Version 5.0a                              ³"
LOCATE 9, 5: PRINT "³            Game based on David Ritchie's game: GLOMP!              ³"
LOCATE 10, 5: PRINT "ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
LOCATE 11, 5: PRINT "³ Cheat!!!:Hit = to activate killer wall mode!!!                     ³"
LOCATE 12, 5: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
WHILE INKEY$ <> "": WEND
ma:
a$ = INKEY$
IF a$ = "=" THEN kw = 1: BEEP: GOTO ea
IF a$ <> "" THEN GOTO ea
GOTO ma

ea:
COLOR 1, 1
LOCATE 5, 5: PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
LOCATE 6, 5: PRINT "³                 Jersey Devil: Advanced version 1.0                 ³"
LOCATE 7, 5: PRINT "³                   A game by Matthew Johnson                        ³"
LOCATE 8, 5: PRINT "³                       JD Version 5.0a                              ³"
LOCATE 9, 5: PRINT "³            Game based on David Ritchie's game: GLOMP!              ³"
LOCATE 10, 5: PRINT "ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
LOCATE 11, 5: PRINT "³ Cheat!!!:Hit = to activate killer wall mode!!!                     ³"
LOCATE 12, 5: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

END SUB

SUB DrawBox (BoxNum)
IF BoxNum = 3 THEN EXIT SUB
IF BoxNum = 1 THEN EXIT SUB
COLOR 0, 7
FOR z = MenuBoxTR(BoxNum) + 1 TO MenuBoxR(BoxNum) - 1: LOCATE 2, z: PRINT "Ä": LOCATE MenuBoxB(BoxNum), z: PRINT "Ä": NEXT
FOR z = 2 TO MenuBoxB(BoxNum) - 1
LOCATE z, MenuBoxTR(BoxNum): PRINT "³": LOCATE z, MenuBoxR(BoxNum): PRINT "³": NEXT
LOCATE 2, MenuBoxTR(BoxNum): PRINT "Ú": LOCATE 2, MenuBoxR(BoxNum): PRINT "¿"
LOCATE MenuBoxB(BoxNum), MenuBoxTR(BoxNum): PRINT "À": LOCATE MenuBoxB(BoxNum), MenuBoxR(BoxNum): PRINT "Ù"

SELECT CASE BoxNum

CASE 2
LOCATE 3, MenuBoxTR(BoxNum) + 1: COLOR 15, 0: PRINT M2$(1)
COLOR 0, 7
LOCATE 4, MenuBoxTR(BoxNum) + 1
IF CLON = 1 THEN PRINT " şCustom level    " ELSE PRINT "  Custom level    "
LOCATE 5, MenuBoxTR(BoxNum) + 1: PRINT M2$(3)


CASE 4
LOCATE 3, MenuBoxTR(BoxNum) + 1: COLOR 15, 0: PRINT M3$(1)
COLOR 0, 7
LOCATE 4, MenuBoxTR(BoxNum) + 1: PRINT M3$(2)

END SELECT

END SUB

SUB EditCustomLevel

COLOR 2, 1: CLS
LOCATE 1, 1: PRINT STRING$(80, "Ä")
LOCATE 1, 30: PRINT "Edit custom level"
'*************************************************
VIEW PRINT 3 TO 24
'*************************************************
PrintMen:
CLS 2
LOCATE 7, 5: PRINT "1 Edit level"
LOCATE 8, 5: PRINT "2 Exit"
LOCATE 10, 5: PRINT "Press number of your choice"
EW1:
a$ = INKEY$
IF a$ = "1" THEN GOTO EditLevel
IF a$ = "2" THEN VIEW PRINT: CLS 0: CLOSE : EXIT SUB
GOTO EW1

EditLevel:
LF = 1
FTL$ = "C:\JDA\LEVELXX.CL"
OPEN FTL$ FOR INPUT AS #1
INPUT #1, TempNumOfDevils
INPUT #1, TempDevilSpeed(1), TempDevilSpeed(2), TempDevilSpeed(3), TempDevilSpeed(4), TempDevilSpeed(5), TempDevilSpeed(6), TempDevilSpeed(7), TempDevilSpeed(8), TempDevilSpeed(9), TempDevilSpeed(10)
INPUT #1, TempDevilStr(1), TempDevilStr(2), TempDevilStr(3), TempDevilStr(4), TempDevilStr(5), TempDevilStr(6), TempDevilStr(7), TempDevilStr(8), TempDevilStr(9), TempDevilStr(10)
INPUT #1, TempDevilMode(1), TempDevilMode(2), TempDevilMode(3), TempDevilMode(4), TempDevilMode(5), TempDevilMode(6), TempDevilMode(7), TempDevilMode(8), TempDevilMode(9), TempDevilMode(10)
INPUT #1, TempP1LSpeed, TempP1LStr, TempP2LSpeed, TempP2LStr
INPUT #1, ObjRat, LvSpc
CLOSE

EditLevel
GOTO PrintMen

'*************************************************
'*************************************************

END SUB

SUB EditLevel
'$DYNAMIC
IF LF <> 1 THEN TempNumOfDevils = 1
VIEW PRINT: COLOR 2, 1: CLS : VIEW PRINT 1 TO 3: LOCATE 1, 1: PRINT STRING$(80, "Ä")
LOCATE 1, LEN(SF$) + 13 / 2: PRINT "Custom level-" + SF$
VIEW PRINT 2 TO 24
LOCATE 2, 1

MainEditMenu:
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
PRINT "Select topic to edit:"
PRINT
PRINT "1 - Jersy Devils"
PRINT
PRINT "2 - Laser beams"
PRINT
PRINT "3 - Objects on the level"
PRINT
PRINT "4 - Level map"
PRINT
PRINT "-----------------"
PRINT "5 - Exit and save"
PRINT
INPUT "Your choice? ", dummy
IF dummy < 1 OR dummy > 5 THEN BEEP: GOTO MainEditMenu
SELECT CASE dummy

CASE 1
SC1:
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
PRINT "[ Devil ] Options:"
PRINT
PRINT "1 - Number of Devils"
PRINT
PRINT "2 - Devil speed"
PRINT
PRINT "3 - Devil mode"
PRINT
PRINT "4 - Devil strengh"
PRINT
PRINT "---------------------"
PRINT "5 - Exit to main menu"
PRINT
INPUT "Your choice? ", dummy: IF dummy < 1 OR dummy > 5 THEN BEEP: GOTO SC1
ON dummy GOTO 11, 12, 13, 14, 15
11 INPUT "Devils? (1 TO 10) ", dummy: IF dummy < 1 OR dummy > 10 THEN BEEP: GOTO 11
TempNumOfDevils = dummy
DevilToEdit = 1

2 GOTO SC1

12 DevilToEdit = 1
PRINT "Devil# "; DevilToEdit
PRINT "Devil to edit? (1 to"; TempNumOfDevils; ") "
INPUT dummy
IF dummy < 1 OR dummy > TempNumOfDevils THEN BEEP: PRINT "Enter # between 1 and"; TempNumOfDevils: GOTO 12
DevilToEdit = dummy
PRINT "Devil# "; DevilToEdit
INPUT "Devil speed? (0 - Fast--->>>> 100+ - Slow (depending on CPU) ", dummy

TempDevilSpeed(DevilToEdit) = dummy
GOTO SC1
13 DevilToEdit = 1
PRINT "Devil# "; DevilToEdit
PRINT "Devil to edit? (1 to"; TempNumOfDevils; ") "
INPUT dummy
IF dummy < 1 OR dummy > TempNumOfDevils THEN BEEP: PRINT "Enter # between 1 and"; TempNumOfDevils: GOTO 13
DevilToEdit = dummy
PM13:
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
PRINT "Devil# "; DevilToEdit
PRINT "Select:"
PRINT
PRINT "1 - Random movements"
PRINT
PRINT "2 - Smart movements"
PRINT
PRINT "--------------------"
PRINT "3 - Exit to previous"
PRINT
INPUT "Option? ", dummy: IF dummy < 1 OR dummy > 3 THEN BEEP: GOTO PM13
IF dummy = 1 THEN
PLAY "L16 O3 CE": TempDevilMode(DevilToEdit) = 1
GOTO PM13
END IF
IF dummy = 2 THEN
PLAY "L16 O3 CE": TempDevilMode(DevilToEdit) = 2
GOTO PM13
END IF
IF dummy = 3 THEN
GOTO SC1
END IF

14 DevilToEdit = 1
PRINT "Devil# "; DevilToEdit
PRINT "Devil to edit? (1 to"; TempNumOfDevils; ") "
INPUT dummy
IF dummy < 0 OR dummy > TempNumOfDevils THEN BEEP: PRINT "Enter # between 1 and"; TempNumOfDevils: GOTO 14
PM14:
INPUT "Strengh? (100-high--->>>10-low) ", dummy
IF dummy < 1 OR dummy > 100 THEN BEEP: GOTO PM14
TempDevilStr(DevilToEdit) = dummy
GOTO SC1
15 GOTO MainEditMenu

'****************************
CASE 2
SC2:
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
PRINT "[ Laser ] Options:"
PRINT
PRINT "1 - Speed"
PRINT
PRINT "2 - Strengh"
PRINT
PRINT "---------------------"
PRINT "3 - Exit to main menu"
PRINT
INPUT "Selection? ", dummy
IF dummy < 1 OR dummy > 3 THEN BEEP: GOTO SC2
ON dummy GOTO 21, 22, 23

21 INPUT "Player 1 or 2? ", DUMMY1: IF DUMMY1 < 1 OR DUMMY1 > 2 THEN GOTO 21
R21:
INPUT "Speed? 1 Fast---===>>> 100+ Slow (Depending on CPU) ", dummy2
IF dummy2 < 1 THEN BEEP: GOTO R21
IF DUMMY1 = 1 THEN TempP1LSpeed = dummy2: PLAY "O2 L16 CE"
IF DUMMY1 = 2 THEN TempP2LSpeed = dummy2: PLAY "O2 L16 CE"
GOTO SC2

22 INPUT "Player 1 or 2? ", DUMMY1: IF DUMMY1 < 1 OR DUMMY1 > 2 THEN GOTO 22
R22:
INPUT "Strengh? 1 Weak---===>>> 100 Powerful ", dummy2
IF dummy2 < 1 OR dummy2 > 100 THEN BEEP: GOTO R22
IF DUMMY1 = 1 THEN TempP1LStr = dummy2: PLAY "O2 L16 CE"
IF DUMMY1 = 2 THEN TempP2LStr = dummy2: PLAY "O2 L16 CE"
GOTO SC2
23 GOTO MainEditMenu

CASE 3
SC3:
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
PRINT "[ Objects ] Options:"
PRINT
INPUT "Ratio of special objects coming up in screen? (x : 100) ", dummy
IF dummy < 1 OR dummy > 100 THEN BEEP: GOTO SC3
ObjRat = dummy: PLAY "O2 L16 CE"
GOTO MainEditMenu

CASE 4
SC4:
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
PRINT "[ Level ] Options:"
PRINT
INPUT "Spaces in level on screen? (50 TO 2000) ", dummy
IF dummy < 50 OR dummy > 2000 THEN BEEP: GOTO SC4
LvSpc = dummy: PLAY "O2 L16 CE"
GOTO MainEditMenu
CASE 5
PRINT "Saving..."
FOR z = 1 TO 10
IF TempDevilSpeed(z) <> 0 AND z > TempNumOfDevils THEN TempDevilSpeed(z) = 0
IF TempDevilStr(z) <> 0 AND z > TempNumOfDevils THEN TempDevilStr(z) = 0
IF TempDevilMode(z) <> 0 AND z > TempNumOfDevils THEN TempDevilMode(z) = 0
NEXT

FTL$ = "C:\JDA\LEVELXX.CL"

OPEN FTL$ FOR OUTPUT AS #1
     
        PRINT #1, TempNumOfDevils
     
        FOR z = 1 TO 9
        PRINT #1, TempDevilSpeed(z);
        NEXT
        PRINT #1, TempDevilSpeed(10)
     
        FOR z = 1 TO 9
        PRINT #1, TempDevilStr(z);
        NEXT
        PRINT #1, TempDevilStr(10)

        FOR z = 1 TO 9
        PRINT #1, TempDevilMode(z);
        NEXT
        PRINT #1, TempDevilMode(10)
      
        PRINT #1, TempP1LSpeed, TempP1LStr, TempP2LSpeed, TempP2LStr
        PRINT #1, ObjRat, LvSpc
CLOSE

VIEW PRINT: CLS
EXIT SUB
END SELECT

END SUB

REM $STATIC
SUB EraseBox (BoxNum) STATIC

IF BoxNum = 3 THEN EXIT SUB
IF BoxNum = 1 THEN EXIT SUB

COLOR 1, 1
FOR z = MenuBoxTR(BoxNum) + 1 TO MenuBoxR(BoxNum) - 1: LOCATE 2, z: PRINT "Ä": LOCATE MenuBoxB(BoxNum), z: PRINT "Ä": NEXT
FOR z = 2 TO MenuBoxB(BoxNum) - 1
LOCATE z, MenuBoxTR(BoxNum): PRINT "³": LOCATE z, MenuBoxR(BoxNum): PRINT "³": NEXT
LOCATE 2, MenuBoxTR(BoxNum): PRINT "Ú": LOCATE 2, MenuBoxR(BoxNum): PRINT "¿"
LOCATE MenuBoxB(BoxNum), MenuBoxTR(BoxNum): PRINT "À": LOCATE MenuBoxB(BoxNum), MenuBoxR(BoxNum): PRINT "Ù"

SELECT CASE BoxNum

CASE 2
COLOR 1, 1
LOCATE 3, MenuBoxTR(BoxNum) + 1: COLOR 1, 1: PRINT M2$(1)
COLOR 1, 1
LOCATE 4, MenuBoxTR(BoxNum) + 1: PRINT M2$(2): LOCATE 5, MenuBoxTR(BoxNum) + 1: PRINT M2$(3)

CASE 4
LOCATE 3, MenuBoxTR(BoxNum) + 1: COLOR 1, 1: PRINT M3$(1)
COLOR 1, 1
LOCATE 4, MenuBoxTR(BoxNum) + 1: PRINT M3$(2)
END SELECT

END SUB

SUB ExitGame
pf = 2
NewGame2
END SUB

SUB MMdn (BoxNum)

SELECT CASE BoxNum
CASE 1
IF MS2 + 1 = 3 THEN MS2 = 1 ELSE MS2 = MS2 + 1
CASE 2
IF MS2 + 1 = 4 THEN MS2 = 1 ELSE MS2 = MS2 + 1
CASE 4
IF MS2 + 1 = 3 THEN MS2 = 1 ELSE MS2 = MS2 + 1
END SELECT
SELECT CASE BoxNum
CASE 2
FOR z = 1 TO 3
IF MS2 = z AND z = 2 THEN IF CLON = 1 THEN COLOR 15, 0: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT " şCustom level    "
IF MS2 = z AND z = 2 THEN IF CLON = 0 THEN COLOR 15, 0: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT "  Custom level    "
IF MS2 <> z AND z = 2 THEN IF CLON = 1 THEN COLOR 0, 7: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT " şCustom level    "
IF MS2 <> z AND z = 2 THEN IF CLON = 0 THEN COLOR 0, 7: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT "  Custom level    "
IF MS2 = z AND z <> 2 THEN COLOR 15, 0: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT M2$(z)
IF MS2 <> z AND z <> 2 THEN COLOR 0, 7: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT M2$(z)
NEXT
CASE 4
FOR z = 1 TO 2
IF MS2 = z THEN COLOR 15, 0: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT M3$(z)
IF MS2 <> z THEN COLOR 0, 7: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT M3$(z)
NEXT
END SELECT

END SUB

SUB MMenu
MenuStart:
COLOR 7, 1: CLS
FOR z = 1 TO 80: PRINT "Û"; : NEXT
FOR z = 1 TO 4
        IF MS = z THEN COLOR 15, 0: LOCATE 1, M(z): PRINT M$(z)
        IF MS <> z THEN COLOR 0, 7: LOCATE 1, M(z): PRINT M$(z)
NEXT z

MenOpen = 0
MS2 = 1

MenuWait:
a$ = INKEY$
IF a$ = CHR$(0) + "H" THEN GOTO MenuUp
IF a$ = CHR$(0) + "P" THEN GOTO MenuDn
IF a$ = CHR$(0) + "K" THEN GOTO MenuLeft
IF a$ = CHR$(0) + "M" THEN GOTO MenuRight
IF a$ = CHR$(13) THEN GOTO MenuRet
IF a$ = CHR$(27) THEN GOTO MenuEsc
GOTO MenuWait

MenuUp:
IF MenOpen = 1 THEN MMup MS
GOTO MenuWait
MenuDn:
IF MenOpen = 1 THEN MMdn MS
GOTO MenuWait

MenuLeft:
IF MenOpen = 1 THEN IF MS - 1 = 0 THEN MS = 4: EraseBox 1: DrawBox 4: MS2 = 1 ELSE IF MenOpen = 1 THEN EraseBox MS: DrawBox MS - 1: MS2 = 1: MS = MS - 1
IF MenOpen = 0 AND MS - 1 = 0 THEN MS = 4 ELSE IF MenOpen = 0 THEN MS = MS - 1
FOR z = 1 TO 4
        IF MS = z THEN COLOR 15, 0: LOCATE 1, M(z): PRINT M$(z)
        IF MS <> z THEN COLOR 0, 7: LOCATE 1, M(z): PRINT M$(z)
NEXT z

GOTO MenuWait

MenuRight:
IF MenOpen = 1 THEN IF MS + 1 = 5 THEN MS = 1: EraseBox 4: DrawBox 1: MS2 = 1 ELSE EraseBox MS: DrawBox MS + 1: MS2 = 1: MS = MS + 1
IF MenOpen = 0 AND MS + 1 = 5 THEN MS = 1 ELSE IF MenOpen = 0 THEN MS = MS + 1
FOR z = 1 TO 4
        IF MS = z THEN COLOR 15, 0: LOCATE 1, M(z): PRINT M$(z)
        IF MS <> z THEN COLOR 0, 7: LOCATE 1, M(z): PRINT M$(z)
NEXT z
GOTO MenuWait

MenuRet:
IF MS = 3 THEN ExitGame
IF MS = 1 THEN NewGame2
IF MenOpen = 1 THEN GOTO DoTask
DrawBox MS
MenOpen = 1
GOTO MenuWait

MenuEsc:
EraseBox MS
MenOpen = 0
GOTO MenuWait

DoTask:
IF MS = 1 AND MS2 = 1 THEN NewGame2
'IF MS = 1 AND MS2 = 1 THEN Loadgame
IF MS = 2 AND MS2 = 1 THEN GOTO Password
IF MS = 2 AND MS2 = 2 THEN GOTO CustomLevelChange
IF MS = 2 AND MS2 = 3 THEN EditCustomLevel: GOTO MenuStart
IF MS = 4 AND MS2 = 2 THEN EraseBox MS: MenOpen = 0: AboutJDA: GOTO MenuStart
IF MS = 4 AND MS2 = 1 THEN EraseBox MS: MenOpen = 0: QuickRef: GOTO MenuStart
CustomLevelChange:
IF CLON = 0 THEN CLON = 1: LOCATE 4, MenuBoxTR(2) + 1: COLOR 15, 0: PRINT " şCustom level    " ELSE CLON = 0: LOCATE 4, MenuBoxTR(2) + 1: COLOR 15, 0: PRINT "  Custom level    "
GOTO MenuWait

Password:
EraseBox MS
MenOpen = 0
PW
GOTO MenuStart

END SUB

SUB MMup (BoxNum)

SELECT CASE BoxNum
CASE 1
IF MS2 - 1 = 0 THEN MS2 = 2 ELSE MS2 = MS2 - 1
CASE 2
IF MS2 - 1 = 0 THEN MS2 = 3 ELSE MS2 = MS2 - 1
CASE 4
IF MS2 - 1 = 0 THEN MS2 = 2 ELSE MS2 = MS2 - 1
END SELECT
SELECT CASE BoxNum
CASE 2
FOR z = 1 TO 3
IF MS2 = z AND z = 2 THEN IF CLON = 1 THEN COLOR 15, 0: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT " şCustom level    "
IF MS2 = z AND z = 2 THEN IF CLON = 0 THEN COLOR 15, 0: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT "  Custom level    "
IF MS2 <> z AND z = 2 THEN IF CLON = 1 THEN COLOR 0, 7: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT " şCustom level    "
IF MS2 <> z AND z = 2 THEN IF CLON = 0 THEN COLOR 0, 7: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT "  Custom level    "
IF MS2 = z AND z <> 2 THEN COLOR 15, 0: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT M2$(z)
IF MS2 <> z AND z <> 2 THEN COLOR 0, 7: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT M2$(z)
NEXT
CASE 4
FOR z = 1 TO 2
IF MS2 = z THEN COLOR 15, 0: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT M3$(z)
IF MS2 <> z THEN COLOR 0, 7: LOCATE z + 2, MenuBoxTR(BoxNum) + 1: PRINT M3$(z)
NEXT
END SELECT

END SUB

SUB NewGame2
OPEN "c:\JDA\temp.jda" FOR OUTPUT AS #1
PRINT #1, pf                    '1=play 2=exit
PRINT #1, CLON
PRINT #1, kw, sm, scm, ap, puo, PWM
PRINT #1, warpgameflag
PRINT #1, wgl
CLOSE
SYSTEM
END SUB

SUB PW
VIEW PRINT 2 TO 24
COLOR 2: LOCATE 2
PRINT "Enter master password:"
INPUT ">", MP$
IF MP$ = "A1B3C5" THEN GOTO se
BEEP: BEEP: COLOR 4: PRINT "Wrong!"
VIEW PRINT: CLS : EXIT SUB

se:
PWM = 1
ST$(0) = "DISABLED"
ST$(1) = "ENABLED"
COLOR 2: PRINT
PRINT "Select an option:"
PRINT
PRINT "1-Killer wall mode -"; ST$(kw)
PRINT "2-Stupify mode     -"; ST$(sm)
PRINT "3-Scatter mode     -"; ST$(scm)
PRINT "4-Autopass         -"; ST$(ap)
PRINT "5-Powerup 100 mode -"; ST$(puo)
PRINT "6-HELP"
PRINT "7-Exit"
PRINT
INPUT ">", dummy
IF dummy = 7 THEN VIEW PRINT: CLS : EXIT SUB
SELECT CASE dummy

CASE 1
IF kw = 0 THEN kw = 1 ELSE kw = 0
PRINT "Killer wall mode is "; ST$(kw)

CASE 2
IF sm = 0 THEN sm = 1 ELSE sm = 0
PRINT "Stupify mode is "; ST$(sm)

CASE 3
IF scm = 0 THEN scm = 1 ELSE scm = 0
PRINT "Scatter mode is "; ST$(scm)

CASE 4
IF ap = 0 THEN ap = 1 ELSE ap = 0
PRINT "Autopass mode is "; ST$(ap)

CASE 5
IF puo = 0 THEN puo = 1 ELSE puo = 0
PRINT "Powerup 100 mode is "; ST$(puo)

CASE 6
PRINT
PRINT "HELP"
PRINT
PRINT "Killer wall mode: Sets all walls to automatically kill player if touched."
PRINT "Stupify mode    : Makes all devils random."
PRINT "Scatter mode    : Scatters devils all over the level. Press 0 to scatter!"
PRINT "Autopass        : Passes player on level. [1] or [2] depending on player."
PRINT "Powerup 100 mode: Makes all power ups appear."
PRINT
INPUT "Press ENTER>", dummy
PRINT

CASE ELSE
BEEP
END SELECT
GOTO se

END SUB

SUB QuickRef
COLOR 2, 1
LOCATE 2, 1
PRINT "Quick reference"
PRINT
PRINT " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
PRINT " ³  Control Player   ³    Control gun    ³                       ³"
PRINT " ÃÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂÄÄÄÄÅÄÄÄÄÂÄÄÄÄÂÄÄÄÄÂÄÄÄÄÅÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
PRINT " ³ UP ³ DN ³ LT ³ LT ³ UP ³ DN ³ LT ³ RT ³ Jump ³                ³"
PRINT " ÃÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
PRINT "1³[UP]³[DN]³[LT]³[LT]³[o] ³[l] ³[k] ³[;] ³ [\]  ³                ³"
PRINT "2³[t] ³[g] ³[f] ³[h] ³[w] ³[s] ³[a] ³[d] ³ [`]  ³                ³"
PRINT "ÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
PRINT CHR$(24) + " Player number - 1 or 2"
PRINT
PRINT "[q] quits"
PRINT
PRINT "***Cheat keys***Cheat code(s) must be activated first***"
PRINT "[1] Player 1 autopass"
PRINT "[2] Player 2 autopass"
PRINT "[0] Scatter"
PRINT
PRINT "Note: Caps Lock must be off before play."
PRINT
PRINT "Press a key..."
SLEEP

END SUB

SUB txtintro
CLS
PRINT "Welcome to JDA!!!"
PRINT "Press a key..."
cd$ = LTRIM$(RTRIM$(COMMAND$))
IF LEFT$(cd$, 7) = "/LEVEL=" THEN
IF RIGHT$(cd$, 2) = "01" THEN wgl = 1
IF RIGHT$(cd$, 2) = "02" THEN wgl = 2
IF RIGHT$(cd$, 2) = "03" THEN wgl = 3
IF RIGHT$(cd$, 2) = "04" THEN wgl = 4
IF RIGHT$(cd$, 2) = "05" THEN wgl = 5
IF RIGHT$(cd$, 2) = "06" THEN wgl = 6
IF RIGHT$(cd$, 2) = "07" THEN wgl = 7
IF RIGHT$(cd$, 2) = "08" THEN wgl = 8
IF RIGHT$(cd$, 2) = "09" THEN wgl = 9
IF RIGHT$(cd$, 2) = "10" THEN wgl = 10
warpgameflag = 1: level = wgl
LOCATE 5, 1: PRINT "Warping to level "; STR$(wgl)
END IF
SLEEP

END SUB

