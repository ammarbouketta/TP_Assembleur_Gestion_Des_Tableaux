;     TP 01 EN ASSEMBLEUR   BOUKETTA AMMAR GROUPE 03.

include 'emu8086.inc'
stack segment
    dw   128  dup(0)
ends

data segment
    ; add your data here! 
        ;declaration des chaines de caracteres qui va me servir pour l'affichage 
                ;                        de l'interface     
    
     entete DB 9,9,201,55 dup (205),187,13,10,9,9,186,"   REPUBLIQUE ALGERIENNE DEMOCRATIQUE ET POPULAIRE     ",186,13,10
            DB 9,9,186,"      MINISTERE DE L'ENSEIGNEMENT SUPERIEUR ET         ",186,13,10 
            DB 9,9,186,"             DE LA RECHERCHE SCIENTIFIQUE              ",186,13,10
            DB 9,9,186,"                                                       ",186,13,10 
            DB 9,9,186,"    ECOLE NATIONALE SUPERIEURE D'INFORMATIQUE          ",186,13,10 
            DB 9,9,186,"                                                       ",186,13,10
            DB 9,9,186,55 dup (4),186,13,10
            DB 9,9,186,"       LE PREMIER TRAVAIL PRATIQUE D'ASSEMBLEUR        ",186,13,10
            DB 9,9,186,"           REALISE PAR: BOUKETTA AMMAR                 ",186,13,10 
            DB 9,9,186,"         SECTION: A           GROUPE: 03               ",186,13,10
            DB 9,9,186,"                  ANNEE UNIVERSITAIRE: 2019/2020       ",186,13,10
            DB 9,9,200,55 dup (205),188,13,10,'$'
            
            
    slogan  DB     " 	    께께께께께께께�        께께께께께      |-----|  ",13,10
            DB     " 		께께께께께께께�       께께께께께께     |-----|  ",13,10
            DB     "         께께                 께께       께�    \_____\ ",13,10
            DB     "         께께                 께�         께    께께께  ",13,10
            DB     " 		께께                  께�              께께께   ",13,10
            DB     " 		께께께께께께께�        께께께께께      께께께   ",13,10
            DB     " 		께께께께께께께�         께께께께께     께께께   ",13,10
            DB     " 		께께                           께께    께께께   ",13,10
            DB     " 		께께                 께         께�    께께께   ",13,10
            DB     " 		께께                 께께      께께    께께께   ",13,10
            DB     " 		께께께께께께께�       께께께께께께     께께께   ",13,10
            DB     " 		께께께께께께께�        께께께께께      께께께  ",13,10,'$'
            
    theme   DB     "     -Ce programme consiste  realiser ce qui suit: ",13,10
            DB     "            *-Lire un ensemble d'entiers reprsents sur des doubles mots.",13,10
            DB     "            *-Ranger tous les entiers lus dans un tableau de deux dimmension .",13,10
            DB     "            *-recherche les indices d'une valeur donner. ",13,10
            DB     "            *-recherche d'une valeur par leur indice .",13,10
            DB     "            *-Mettre a jour une valeur dans le tableau d'une case donner. ",13,10
            DB     "            *-Rajouter une ligne au tableau avec des valeurs donnees en entree.",13,10,'$'
            
    msg1    DB 13,10,"                        ** BIENVENUE A NOTRE PROGRAMME **  $"
    msg3    DB 13,10,"   -Veuillez introduire la taille de votre tableau:  " 
    msgl    DB 13,10,"   -Veuillez introduire le nombre de ligne de votre tableau : " 
    msgc    DB 13,10,"   -Veuillez introduire le nombre de colonne de votre tableau : "
    msg4    DB 13,10,"  -Veuillez saisir les donnees de votre tableau: "
    msg5    DB "   -Le tableau introduit est le suivant: " 
    
    mess4   DB 13,10,"   -Le programme a termin",130," avec succ",138,"s.",13,10,'$'       
            
    quit    DB 13,10,'Appuyez sur une touche pour quitter ...$'
    revenir DB 13,10,"   -Voulez vous essayer une autre fois?(0/1)  0-non    1-oui. "
            DB 13,10,"              Votre r",130,"ponse est: ",'$'
            
    tab     DB 100 dup (0h)    
    lig     DW ?
    col     DW ?
    cpt11   DB ?
    cpt1    DW ?  
    cpt2    DW ?  
    cpt     DW ?
    cpt3    DW ?
    i       DW ?
    j       DW ?
    reponse DB 6 dup (0h)
    oui     DB 'oui$'
    non     DB 'non$'
    pkey  db "press any key...$"
ends

;================================================================================================

code segment

     new_ligne macro ;une macro qui serve a faire un saut de ligne
            mov dl,13
            mov ah,2
            int 21h
            
            mov dl,10
            mov ah,2
            int 21h
     endm 
     
;================================================================================================

 start:

        mov     ax, data
        mov     ds, ax
        mov     es, ax 
    
    print   '-Veuillez patientez quelques secondes...'
    
    new_ligne 
    mov si,0         
aff1:
    mov cx, 1
    mov ah,09h
    mov al, msg1[si]
    mov bl, 011
    int 10h             ;affichage de message bienvenue a notre programme
    mov ah,0eh
    int 10h
    inc si
    cmp si,61d
    jc aff1
    
    new_ligne
    new_ligne
    new_ligne
    new_ligne
    
    lea dx, slogan 
    mov ah, 9          ;affichage du slogan de l'ecole
    int 21H
                
    new_ligne
    new_ligne
    print   '                Pour continuer veuillez appuyer sur une touche...!'
    mov     ax,0c01h
    int     21h  
    
    call CLEAR_SCREEN
    new_ligne
    new_ligne
    new_ligne
             
    lea dx, entete
    mov ah, 9             ;affichage de l'entete du programme qui contient des informations sur le realisateur
    int 21H    
        
    new_ligne
    new_ligne
    new_ligne
    
    print   '                Pour continuer veuillez appuyer sur une touche...!'
    mov     ax,0c01h
    int     21h  
    
    call clear_screen
    new_ligne
    new_ligne
    new_ligne
    
    mov al, 1
    mov bh, 0
    mov bl, 4_eh
	mov cx, aff2 -offset msg2  
    mov dl, 0                   ;affichage du theme du programme 
    mov dh, 6
    push cs
    pop  es
	mov bp, offset msg2
	mov ah, 13h
    int 10h  
    
    new_ligne
    new_ligne                    
	mov si,0                    
    jmp     aff2
msg2 DB      "THEME DU PROGRAMME:"
aff2:
    new_ligne
    new_ligne
    lea dx, theme           ;affichage du theme du programme
    mov ah, 9
    int 21h
    
    new_ligne
    new_ligne
    new_ligne
    
    print   '              Pour continuer veuillez appuyer sur une touche...!'
    mov     ax,0c01h
    int     21h
begin:    
    call clear_screen
    new_ligne
    new_ligne
    
    mov si,0         

affl:
    mov cx, 1
    mov ah,09h
    mov al, msgl[si]         ;message du lecture de nombre du ligne du  tableau 
    mov bl, 010
    int 10h 
    mov ah, 0eh
    int 10h
    inc si
    cmp si,65d
    jc affl
    
    
    mov cx, 0d
    mov lig, 0d              ;on lit la nombre du ligne et on le met dans cx
    call scan_num
    cmp cx, 0d
    jg con 
    new_ligne
    new_ligne
    print " -Le nombre du ligne du tableau est incorrecte!!"
    new_ligne
    mov si, 0
    jmp affl    
 mov di,0
 con:    
    mov lig, cx 
    
    
    new_ligne
    new_ligne
 mov si, 0   
affc:
    mov cx, 1
    mov ah,09h
    mov al, msgc[si]         ;message du lecture de nombre du colonne du  tableau 
    mov bl, 010
    int 10h
    mov ah, 0eh
    int 10h
    inc si
    cmp si,67d
    jc affc
    
    
    mov cx, 0d
    mov col, 0d              ;on lit la nombre du colonne et on le met dans cx
    call scan_num
    cmp cx, 0d
    jg con1 
    new_ligne
    new_ligne
    print " -Le nombre du colonne du tableau est incorrecte!!"
    new_ligne
    mov si, 0
    jmp affc
con1:    
    mov col, cx 
    
    
    new_ligne
    new_ligne
    
    mov si,0
aff4:
    mov cx, 1
    mov ah,09h
    mov al, msg4[si]
    mov bl, 1110b          ;le messsage de saisie des donnees du tableau
    int 10h             
    mov ah,0eh
    int 10h
    inc si
    cmp si,50d
    jc aff4
    new_ligne
    new_ligne 
    print " -Entrer des donnees(des nombre signee sur un octet ou des lettres) :"
    new_ligne
    new_ligne
    call lect_tab_2d           ;appel a la procedure de lecture des donnees et les mettre dans un 
                           ;            tableau a 2 dimensions
    new_ligne
    new_ligne
    new_ligne
    
    print   '                Pour continuer veuillez appuyer sur une touche...!'
    mov     ax,0c01h
    int     21h
                
    new_ligne
    call clear_screen
     
    new_ligne
    new_ligne       
    new_ligne
    
    print "  -Les valeurs alphanumeriques introduits sont les suivants: "
    new_ligne
    new_ligne

    call ecrit_tab_2d         ;appel a la procedure de l'ecriture du tableau
                         ; ecriture du tableau introduit
   
    new_ligne
    new_ligne
         
    
    print   '                Pour continuer veuillez appuyer sur une touche...!'
    mov     ax,0c01h
    int     21h
                
    new_ligne
    call clear_screen 
    new_ligne
    new_ligne
    new_ligne
    print '  ======================================================================'
    new_ligne
    print "  || Afficher la valeur de la case qui se trouve dans l'indice i et j :||"
    new_ligne 
    print '  ======================================================================' 
    new_ligne
    new_ligne 
    call affich_val  
    
    
    new_ligne
    new_ligne
    new_ligne
     print   '                Pour continuer veuillez appuyer sur une touche...!'
    
    mov     ax,0c01h
    int     21h
                
    new_ligne
    call clear_screen
    new_ligne
    new_ligne
    new_ligne
    print '  ================================================'
    new_ligne
    print "  || Afficher les indices d'une valeur donner  :||"
    new_ligne 
    print '  ================================================' 
    new_ligne
    new_ligne 
    call affich_ind_val 
   
    new_ligne
    new_ligne
    new_ligne  
  
     print   '                Pour continuer veuillez appuyer sur une touche...!'
    mov     ax,0c01h
    int     21h
                
    new_ligne
    call clear_screen
    new_ligne
    new_ligne
    new_ligne
    print '  ==========================================================================='
    new_ligne
    print "  || Mettre a jour une valeur dans le tableau d'une case  donner en entree :||"
    new_ligne 
    print '  ===========================================================================' 
  
    new_ligne
    new_ligne
    
    call met_ajour_val
    new_ligne         
    new_ligne
    new_ligne
    print ' affichage du  tableau apres mettre a jour une valeur :'
    
    call ecrit_tab_2d
    
    new_ligne
    new_ligne
    new_ligne
    new_ligne
    new_ligne 
     
    print   '                Pour continuer veuillez appuyer sur une touche...!'
    mov     ax,0c01h
    int     21h
                
    new_ligne
    call clear_screen
    new_ligne
    new_ligne
    new_ligne
    print '  ======================================================================'
    new_ligne
    print '  ||Rajouter une ligne au tableau T avec des valeurs donnees en entree:|| '
    new_ligne 
    print '  ======================================================================'
    
    new_ligne
    new_ligne
     
    print '  ==========================================='
    new_ligne
    print '  || Introduire les valeurs de cette ligne :|| '
    new_ligne 
    print '  ==========================================='
    
    call rajout_ligne
    new_ligne
    new_ligne
    new_ligne
    print ' affichage du  tableau apres rajouter une ligne  : '
    new_ligne   
    call ecrit_tab_2d
    
    new_ligne
    new_ligne
    new_ligne
    new_ligne
    new_ligne 

    new_ligne            

    new_ligne 
cll:    
    lea dx, revenir
    mov ah,9
    int 21h
    
    mov ah, 1d           ;la boucle qui permet de retourner au debut du programme
    int 21h              ;et de pouvoir faire d'autres jeux d'essais sans fermer le 
    sub al, 48d          ;programme
    
    cmp al, 1d
    je begin
    cmp al, 2
    je fin     
     
    jmp fin
;===============================================================================================
lire_donnee    proc   
            push    ax
            push    si
            push    di
            push    dx
            mov     cx,0
            mov     bx,0 
                 ; la procedure qui permet de lire un donnee alphanumerique
 lect:      mov     ah,1           ;  signe represente sur 8 bits
            int     21h            ; le resultat:bl--> contient la donnee
            cmp     al,20h                       
            je      lect
            cmp     al,'-'
            jne     suit 
            mov     dh,1
            
 tq_l:      mov     ah,1
            int     21h 
 suit:      cmp     al,13
            je      ftq            ;il faut lire des nombre positif ou negative  
            cmp     al,32
            je      ftq            ;dans l'intervalle [-128,127](sur un octet)
            cmp     al,30h
            jb      err1            ;ou lire des lettre de l'alphabet majuscule ou miniscule 
            
            cmp     al,7ah
            ja      err1
             
            cmp     al,39h
            jbe     et2
            cmp     al,41h
            jb      err1
            
            cmp     al,5ah
            jbe      et2
            cmp     al,61h
            jb      err1
     et2:                       
            mov     si,bx
   
            shl     si,1
            mov     bx,si  
        
            shl     si,1
        
            shl     si,1
        
            add     bx,si  
            cmp     al,39h
            ja      cbn
            sub     al,48
     cbn:   cbw
            add     bx,ax 
          
            cmp     bx,128
            jg      err              
            jmp     tq_l
err:        mov     dl,8 
            sub     bx,ax
            sub     bx,si  
            sar     si,1
            sar     si,1
            mov     si,bx
            sar     si,1
            mov     bx,si 
            
err1:       mov     dl,8
            mov     ah,2
            int     21h 
            mov     dl,20h
            mov     ah,2
            int     21h 
            mov     dl,8
            mov     ah,2
            int     21h
            mov     dl,7
            mov     ah,2
            int     21h
            jmp     tq_l
            
 
 ftq:       cmp     dh,1
            jne     pos
            mov     ax,-1
            cwd
            sub     ax,bx
            sbb     dx,cx
            add     ax,1
            adc     dx,0
            mov     bx,ax
            mov     cx,dx
          
pos:        pop     dx
            pop     di
            pop     si
            pop     ax  
            ret
  
lire_donnee     endp
;================================================================================================
ecrire proc
       pusha   
       lea      di,Case+14 
       mov      cs:signe,20h
       mov      bp,10 
       cmp      bx,128
       jl       eteq
       not      bl                   ; la procedure qui permet d'ecrire une donnee alphanumerique 
       add      bx,1                 ;              bx--> contient le mot
       mov      cs:signe,'-' 
    
eteq:
        mov     dx,0
        mov     ax,bx 
        div     bp 
        mov     bx,ax
       
        add     dl,30h
        mov     cs:[di],dl
        dec     di
        cmp     bx,0
        jne     eteq
        push    ds
        mov     ax,cs
        mov     ds,ax
        
        mov     al,signe
        mov     [di],al
        dec     di 
        lea     dx,di
        mov     ah,09h
        int     21h 
        mov     cx, 15d 
        mov     si, 0d
  init:
        mov     Case[si], 20h
        inc     si
        loop    init
        pop     ds
        popa
        ret
    Case    DB  15 DUP(20H),'$' 
    signe   db  ?
ecrire endp 

;===============================================================================================
lect_tab_2d proc 
    
 
    
    mov bx, lig
    mov ax, col
    mul bx 
    mov cx, ax      
    mov i,0  
    mov j,0
    mov si, 0
    
bcl1:
   
bcl2:  
    new_ligne
    print " -TAB["                   ; la procedure qui permet de lire des donnees
    mov ax, i                      ; et les ranger dans un tableau de 2 dimenssion 
    call print_num_uns              
    print "]"
    print "["
    mov ax, j
    call print_num_uns 
    print "]"
    print "="
   
    mov cpt, cx
    mov bx, 0d 
    call lire_donnee   ; appel a la fonction de lecture 
    mov tab[si], bl  
    add si, 1 
    mov cx, cpt    
    inc j
    mov ax, col
    cmp ax, j
    je  fin1
    loop bcl2
 fin1:
    mov j, 0
    inc i
    mov ax, lig
    cmp ax, i
    je fin2 
    
    loop bcl2
fin2:    jmp finn

finn:
    ret         
lect_tab_2d endp
;===============================================================================================
ecrit_tab_2d proc
    new_ligne
    new_ligne
    
    
         ; la procedure qui permet d'ecriture d'une tableau de deux dimenssion  
    mov bx, lig
    mov ax, col
    mul bx 
    mov cx, ax 
     
                     ; tableau contenant des donnees alphanumeriques
    mov si, 0d 
    mov i, 0
    mov j, 0 
bcl1e:
new_ligne
new_ligne
bcl2e:
    mov cpt, cx  
    mov bx, 0d
    mov bl, tab[si]
    add si, 1d
    print "      "
    call ecrire     ; appel a la fonction d'ecriture
    mov cx,cpt
    inc j
    mov ax, col
    cmp ax,j
    je  fin2e
    loop bcl2e
fin2e:
    mov j,0 
    inc i 
    mov ax,lig
    cmp ax,i 
    je fin1e
    loop bcl1e
    new_ligne
fin1e:
    ret
ecrit_tab_2d endp
;===============================================================================================
affich_val proc
    mov si, 0d 
    mov i, 0
    mov j, 0
    mov cpt3,0
aaaa:
    new_ligne 
    print "  entrer une indice de ligne inferieur a le nombre de ligne !! "  
    new_ligne
    print "   entrer l'indice de la ligne ou se trouve la valeur  : " 
    mov cx,0d
    mov cpt1, 0d              ;on lit le nombre du colonne et on le met dans cx
    call scan_num
    mov cpt1,cx
    cmp cx,lig
    jge aaaa
    new_ligne
    new_ligne
bbbb:
    new_ligne 
    print "   entrer une indice de colonne inferieur a le nombre de colonne  !! "
    new_ligne      
    print "   entrer l'indice de la colonne ou se trouve la valeur  : "
    mov cx,0d          
    mov cpt2, 0d              ;on lit le nombre du colonne et on le met dans cx
    call scan_num
    mov cpt2,cx
    cmp cx,col
    jge bbbb 

    mov bx, lig
    mov ax, col
    mul bx 
    mov cx, ax 
  
 ; le procedure qui permet d'afficher une valeur donnant leur indices  
        
bcl1e1:
bcl2e1:
    mov cpt, cx  
    mov bx, 0d
    mov bl, tab[si]
    add si, 1d   
    mov bp,j
    cmp bp,cpt2
    jne fff 
    mov bp,i
    cmp bp,cpt1
    jne fff
    new_ligne
    new_ligne 
    print "   la valeur est trouver ."
    new_ligne
    print "   la valeur = " 
    call ecrire     ; appel a la fonction d'ecriture 
    mov cpt3,111h
fff:    mov cx,cpt
    inc j
    mov ax, col
    cmp ax,j
    je  fin2e1
    loop bcl2e1
fin2e1:


    mov j,0 
    inc i 
    mov ax,lig
    cmp ax,i 
    je fin1e1
    loop bcl1e1

fin1e1: 
    cmp cpt3,111h
    je etec1
    print " la valeur n'existe pas dans votre tableau !!! "
etec1:   
    ret
affich_val endp    
           
;===============================================================================================

affich_ind_val proc
    mov si, 0d 
    mov i, 0
    mov j, 0
    mov cpt3,0 
    new_ligne 
    print "entrer une valeur alphanumerique :"
    mov bx,0d
    mov cpt11, 0d              ;on lit la nombre du colonne et on le met dans cx
    call lire_donnee
    mov cpt11,bl
    new_ligne      
    mov bx, lig
    mov ax, col
    mul bx 
    mov cx, ax 
  
      
bcl1e2:
bcl2e2:
    mov cpt, cx  
    mov bx, 0d
    mov bl, tab[si]
    add si, 1d  
    cmp bl, cpt11
    jne ffff 
    mov bx ,i
    new_ligne
    print "   l'indice de la ligne ou se trouve la valeur est  : "
    call ecrire     ; appel a la fonction d'ecriture 
    mov bx ,j 
    new_ligne                                                   
    print "   l'indice de la colonne ou se trouve la valeur est  : "
    call ecrire     ; appel a la fonction d'ecriture   
    mov cpt3,111d
ffff:   
    mov cx,cpt
    inc j
    mov ax, col
    cmp ax,j
    je  fin2e2
    loop bcl2e2
fin2e2:
    mov j,0 
    inc i 
    mov ax,lig
    cmp ax,i 
    je fin1e2
    loop bcl1e2

fin1e2:

    cmp cpt3,111d
    je ppp
    print "   la valeur n'existe pas dans votre tableau !!! "
ppp: 
    ret
    
 affich_ind_val endp
;===============================================================================================

met_ajour_val proc
    mov si, 0d 
    mov i, 0
    mov j, 0
aaab:
    new_ligne 
    print "   entrer une indice de ligne inferieur a le nombre de ligne !! "  
    new_ligne
    print "   entrer l'indice de la ligne ou se trouve la valeur  : " 
    mov cx,0d
    mov cpt1, 0d              ;on lit la nombre du colonne et on le met dans cx
    call scan_num
    mov cpt1,cx
    cmp cx,lig
    jge aaab 
    new_ligne
    new_ligne
bbba:
    new_ligne
    print "   entrer une indice de colonne inferieur a le nombre de colonne  !! "
    new_ligne      
    print "   entrer l'indice de la colonne ou se trouve la valeur  : "
    mov cx,0d          
    mov cpt2, 0d              ;on lit le nombre du colonne et on le met dans cx
    call scan_num
    mov cpt2,cx
    cmp cx,col
    jge bbba 

    mov bx, lig
    mov ax, col
    mul bx 
    mov cx, ax 
  
   
     
bcl1e3:
bcl2e3:
    mov cpt, cx  
    mov bx, 0d
    mov cx, 0d
    mov bl, tab[si]
    add si, 1d    
    mov bp,j
    cmp bp,cpt2
    jne ffa 
    mov bp,i
    cmp bp,cpt1
    jne ffa
    new_ligne 
    new_ligne
    print "   la valeur est trouver ."
    new_ligne 
   
    print "   la valeur =  " 
 
    call ecrire     ; appel a la fonction d'ecriture  
        new_ligne
        new_ligne
    print "   remplacer cette valeur par une autre :"
    new_ligne 
    new_ligne     
    print " -TAB["                   ; la procedure qui permet de lire des donnees
    mov ax, i                      ; et les ranger dans un tableau
    call print_num_uns              
    print "]"
    print "["
    mov ax, j
    call print_num_uns 
    print "]"
    print "="
    mov cx, 0d
    mov bx, 0d
    call lire_donnee      ; appel a la fonction de lecture
    sub si,1d
    mov tab[si], bl
    add si, 1d
    
   
ffa:    mov cx,cpt
    inc j
    mov ax, col
    cmp ax,j
    je  fin2e3
    loop bcl2e3
fin2e3: 

mov j,0 
inc i 
mov ax,lig
cmp ax,i 
je fin1e3
loop bcl1e3
fin1e3:

    ret   
    met_ajour_val endp
    

;===============================================================================================               
 rajout_ligne proc
    new_ligne
    new_ligne
    
    
         
    mov bx, lig 
    mov lig, bx
    add bx, 1
    mov lig, bx
    mov ax, col
    mul bx 
    mov cx, ax 
    new_ligne
    mov cpt3,cx
     
                     ; tableau contenant des donnees alphanumeriques
    mov si, 0d 
    mov i, 0
    mov j, 0 
bclf1:

bclf2:
    mov ax,lig
    sub ax,1
    cmp ax,i
    je cont
    mov cpt, cx  
    mov bx, 0d
    mov bl, tab[si]
    add si, 1d  
    mov cx, cpt
    inc j
    mov ax, col
    cmp ax, j
    je  finf2   
   
     loop bclf2
cont:
new_ligne
    print " -TAB["                   ; la procedure qui permet de lire des donnees
    mov ax, i                     ; et les ranger dans un tableau
    call print_num_uns              
    print "]"
    print "["
    mov ax, j
    call print_num_uns 
    print "]"
    print "=" 
    mov cx, 0d
    mov bx, 0d
    call lire_donnee      ; appel a la fonction de lecture  

    mov tab[si], bl
    add si,1d 
    inc j
    mov ax, col
    cmp ax,j
    je  finf2  
    loop bclf2
    
finf2:
mov j,0 
inc i
mov ax,lig
cmp ax,i 
je finf1
loop bclf1
new_ligne
finf1:
    ret 
    rajout_ligne endp  
;===============================================================================================

fin: 

    new_ligne
    new_ligne
    mov si,0
afff:
    mov cx,1
    mov ah,09h
    mov al, mess4[si]
    mov bl, 010
    int 10h
    mov ah,0eh                 ;affichage du message du fin du programme succes
    int 10h
    inc si
    cmp si,41
    jc afff
    
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h
    
    ends
DEFINE_CLEAR_SCREEN 
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS


end start ; set entry point and stop the assembler.
