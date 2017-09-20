@Echo off
Set mkgmap_SkipSplitter=True
Goto lbl_testAreas

Rem 1=Benelux, 2=Alpen, 3=Frankrijk - Noord, 4=Frankrijk - Zuid
Rem 5=Duitsland - Noord, 6=Duitsland - Zuid, 7=Italie, 8=Spanje, 9=Engeland
Rem 10=VRIJ, 11=Griekenland, 12=Oostblok, 13=Noorwegen, 14=Finland

Rem 21=Zuid Limburg, 22=Chiemsee, 23=Knokke, 24=Schiphol, 25=Bilbao

Rem mkgmap.bat %config% %skip_splitter%
Rem ==========================================================
Rem Call mkgmap.bat 1 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 2 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 3 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 4 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 5 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 6 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 7 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 8 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 9 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 10 %mkgmap_SkipSplitter%
Rem Call mkgmap.bat 11 %mkgmap_SkipSplitter%
Call mkgmap.bat 12 %mkgmap_SkipSplitter%
Call mkgmap.bat 13 %mkgmap_SkipSplitter%
Call mkgmap.bat 14 %mkgmap_SkipSplitter%

Goto lbl_end

:lbl_testAreas
Call mkgmap.bat 21 %mkgmap_SkipSplitter%
Call mkgmap.bat 22 %mkgmap_SkipSplitter%
Call mkgmap.bat 23 %mkgmap_SkipSplitter%
Call mkgmap.bat 24 %mkgmap_SkipSplitter%
Call mkgmap.bat 25 %mkgmap_SkipSplitter%
:lbl_end
Pause