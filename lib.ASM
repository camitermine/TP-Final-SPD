.8086
.model small
.stack 100h

.data 
    ventana_ancho  dw 140h
    ventana_altura dw 0c8h
    ventana_limite dw 6
    pelota_x       dw 0ah
    pelota_y       dw 64h
    pelota_tamanio dw 04h
    pelota_velx    dw 05h
    pelota_vely    dw 02h
    barra_x        dw 87h
    barra_y        dw 0B4h
    barra_ancho    dw 35h
    barra_alto     dw 05h
    f_y            dw 0Ah       ;la posicion en y donde se empieza a dibujar cada fila de bloques (variable que se va pisando)
    f1_y           dw 0Ah
    barra_vel      dw 07h
    bloque_f       db 0
    f_x            dw 02h       ;la posicion en x donde se empiezan a dibujar todas las filas de bloques
    alto_bloque    dw 0Bh
    ancho_bloque   dw 2Bh
    color          db 09h
    tiempo_aux     db  0
    fila1          db  7 dup (1h), 0dh,0ah,24h  
    fila2          db  7 dup (1h), 0dh,0ah,24h  
    fila3          db  7 dup (1h), 0dh,0ah,24h  
    fila4          db  7 dup (1h), 0dh,0ah,24h  
    fila5          db  7 dup (1h), 0dh,0ah,24h  
    fila6          db  7 dup (1h), 0dh,0ah,24h  

    score dw 0
    vidas dw 33h, 24h
    scor_msg db "Score : $" , 0dh, 0ah, 24h

    bienvenida      DB  0AH,0DH,"                  ================================"
                    DB  0AH,0DH,"                  ================================"
                    DB  0AH,0DH,"                  ========   BIENVENIDO   ========"
                    DB  0AH,0DH,"                  ========                ========"
                    DB  0AH,0DH,"                  ========                ========"
                    DB  0AH,0DH,"                  ========  * ARKANOID *  ========"
                    DB  0AH,0DH,"                  ================================"
                    DB  0AH,0DH,"                  ================================$"
        
    str2            DB  0AH,0DH,"======================== PROGRAMADO POR ========================"
                    DB  0AH,0DH,"================                                ================"
                    DB  0AH,0DH,"================         LAUTARO PRIETO         ================"
                    DB  0AH,0DH,"================                                ================"
                    DB  0AH,0DH,"================        ANNABELLA PAGANO        ================"
                    DB  0AH,0DH,"================                                ================"  
                    DB  0AH,0DH,"================     MATIAS NICOLAS PALACIO     ================"
                    DB  0AH,0DH,"================                                ================"
                    DB  0AH,0DH,"================         CAMILA TERMINE         ================"
                    DB  0AH,0DH,"================================================================$"
       
        
    str3            DB  0AH,0DH,"========================= INSTRUCCIONES ========================="
                    DB  0AH,0DH,"================================================================="
                    DB  0AH,0DH,"=  *CONTROLA UNA BARRA QUE REBOTA LA PELOTA HACIA ARRIBA PARA   ="
                    DB  0AH,0DH,"=                    DESTRUIR LADRILLOS                         ="
                    DB  0AH,0DH,"= OBJETIVO:ELIMINAR TODOS LOS LADRILLOS SIN DEJAR QUE LA PELOTA ="
                    DB  0AH,0DH,"=                     CAIGA AL FONDO                            ="
                    DB  0AH,0DH,"================================================================="
                    DB  0AH,0DH,"================================================================="
                    DB  0AH,0DH,"=    PON A JUEGO TUS HABILIDADES DE REFLEJOS Y ESTRATEGIA       ="
                    DB  0AH,0DH,"=               EN ESTE ADICTIVO DESAFIO !                      ="
                    DB  0AH,0DH,"================================================================="
                    DB  0AH,0DH,"=================================================================$"
       
    str5            DB  0AH,0DH,"=========================== CONTROLES ==========================="
                    DB  0AH,0DH,"================================================================="
                    DB  0AH,0DH,"================================================================="
                    DB  0AH,0DH,0AH,0DH
                    DB  0AH,0DH,"================================================================="
                    DB  0AH,0DH,"==       DESPLAZA LA BARRA CON LAS TECLAS 'A' Y 'D'            =="
                    DB  0AH,0DH,"==                                                             =="
                    DB  0AH,0DH,"==       'A' PARA MOVERSE A LA IZQUIERDA Y 'D' A LA DERECHA    =="
                    DB  0AH,0DH,"=================================================================$"   
       
                                                                      
    str6            DB 0AH,0DH,"                  =========================="
                    DB 0AH,0DH,"                  =========================="
                    DB 0AH,0DH,"                  ====    GRACIAS POR   ===="
                    DB 0AH,0DH,"                  ====       JUGAR      ===="
                    DB 0AH,0DH,"                  ====      ARKANOID    ===="
                    DB 0AH,0DH,"                  =========================="
                    DB 0AH,0DH,"                  ==========================$"
                        
    LOSE_MSG        DB 0AH,0DH,"                         "
                    DB 0AH,0DH,"                         "
                    DB 0AH,0DH,"          PERDISTE!      "
                    DB 0AH,0DH,"     TU PUNTAJE FUE DE: ",24h  
             
    cartel1         DB 0AH,0DH,"                  ==========================="
                    DB 0AH,0DH,"                  ===========================",0AH,0DH,'$'

    item1           DB 'JUGAR          ===',0AH,0DH,'$'
    item2           DB 'PROGRAMADO POR ===',0AH,0DH,'$'
    item3           DB 'INSTRUCCIONES  ===',0AH,0DH,'$'
    item4           DB 'PUNTUACIONES   ===',0AH,0DH,'$'
    item5           DB 'CONTROLES      ===',0AH,0DH,'$'
    item6           DB 'SALIR          ===',0AH,0DH,'$'        
    item7           DB "                  ==========================="
                    DB 0AH,0DH,"                  ===========================$"


    WIN_MSG         DB 0AH,0DH,"                          "
                    DB 0AH,0DH,"                          "
                    DB 0AH,0DH,"          VICTORIA!       "
                    DB 0AH,0DH,"     TU PUNTAJE FUE DE: 42", 0AH, 0DH, 24h

   
    seleccionado    DW 0    
    menu_contador   DW 6
    up              EQU     48h
    down            EQU     50h

    items_menu      DW item1, item2 , item3, item4 , item5, item6, item7

   
    selector        DB '                  ==== ->  $'
    limpiar_selecto DB '                  ====     $'  
    cartelVidas     DB 0AH,0DH,"                         "
                    DB 0AH,0DH,"                         "
                    DB 0AH,0DH,"   ENTER PARA CONTINUAR  "
                    DB 0AH,0DH,"     VIDAS RESTANTES:  ",24h  

.code 
    public limpiar_pantalla
    public tiempo_partida1
    public menu 
    public msj_bienvenida

    menu proc  
        push ax
        push bx
        push cx
        push dx    

        start:
            print_menu:

                call limpiar_pantalla1

                mov ah, 9
                lea dx, cartel1
                int 21h
            
                mov bx, 0
                mov cx, menu_contador
                imprimir_items:
                    mov ax, bx
                    shr ax, 1  
                    cmp ax, seleccionado
                    jne no_seleccionado
                
                    lea dx, selector
                    mov ah, 9
                    int 21h
                    
                    jmp cont
                no_seleccionado:
                    lea dx, limpiar_selecto
                    mov ah, 9
                    int 21h
                cont:   
                    mov dx, items_menu[bx]
                    mov ah, 9
                    int 21h
                
                    add bx, 2  
                loop imprimir_items
            
                mov ah, 9
                lea dx, item7
                int 21h
                
                chequear_opcion:
                mov ah, 1
                int 16h
                jz salto
            
                mov ah, 00h
                int 16h
            
                cmp al, 1bh
                je esEsc
            
                cmp ah, up
                jne     not_up
                sub     seleccionado, 1
                not_up:
            
                cmp ah, down
                jne     not_down
                add     seleccionado, 1
                not_down:
                
                cmp ah, 1ch
                jne saltoo
                cmp seleccionado, 0
                jne not_item_0
                jmp limpiar_pantalla
                not_item_0:
                    cmp seleccionado, 1
                    jne not_item_1
                    call limpiar_pantalla1
                    lea dx, str2
                    mov ah, 9
                    int 21h          
                    mov ah, 1
                    int 21h
                not_item_1:
                    cmp seleccionado, 2
                    jne not_item_2
                    call limpiar_pantalla1
                    jmp saltear1
                salto:
                    jmp no_opcion
                saltear1:
                    lea dx, str3
                    mov ah, 9
                    int 21h
                    jmp saltear2
                esEsc:
                    jmp not_enter
                saltear2:        
                    mov ah, 1
                    int 21h
                not_item_2:
                    cmp seleccionado,3
                    jne not_item_3
                    call limpiar_pantalla1  
                    mov ah, 1
                    int 21h
                not_item_3:
                    cmp seleccionado,4
                    jne not_item_4
                    call limpiar_pantalla1
                    lea dx, str5
                    mov ah, 9
                    int 21h         
                    mov ah, 1
                    int 21h  
                not_item_4:
                    cmp seleccionado,5
                    jne not_item_5
                    call limpiar_pantalla1
                    lea dx, str6
                    mov ah, 9
                    int 21h         
                    mov ah, 1
                    int 21h   
                    jmp stop_prog
                saltoo:
                    jmp not_enter
                not_item_5:
                    mov ah, 00h
                    int 16h
                not_enter:
                    cmp seleccionado, -1
                    jnle ok1
                    mov seleccionado, 0
                ok1:
                    mov ax, menu_contador
                    cmp    seleccionado, ax
                    jnge ok2
                    dec    ax
                    mov    seleccionado, ax
                ok2:
                    jmp print_menu
            
                no_opcion:
                    jmp chequear_opcion
            
            stop_prog:
                mov ax, 4c00h
                int 21h
        
        pop dx 
        pop cx  
        pop bx      
        pop ax  
        ret     
    menu endp
                   
    msj_bienvenida proc
        push ax
        push bx
        push cx
        push dx 
                                
        call limpiar_pantalla1
        mov ah, 9
        lea dx, bienvenida
        int 21h

        mov ah, 1
        int 21h

        pop dx 
        pop cx  
        pop bx      
        pop ax  
        ret   
    msj_bienvenida endp                  
                         
    limpiar_pantalla1 proc
        push ax
        push ds
        push bx
        push cx
        push di  

        mov ax, 40h 
        mov ds, ax
        mov ah, 06h
        mov al, 0
        mov bh, 07
        mov ch, 0
        mov cl, 0
        mov di, 84h
        mov dh, [di]
        mov di, 4ah
        mov dl, [di]
        dec dl
        int 10h

        mov bh, 0
        mov dl, 0
        mov dh, 0
        mov ah, 02
        int 10h

        pop di
        pop cx
        pop bx
        pop ds
        pop ax

        ret
    limpiar_pantalla1 endp

    ;Cada un segundo llama a todas las funciones que hacer funcionar el juego
    ; 
    tiempo_partida1 proc
        tiempo_partida:
            mov ah, 2ch         ;funcion tiempo
            int 21h
            cmp dl,tiempo_aux   ;en dl se almacenan los segundos
            je tiempo_partida
            mov tiempo_aux, dl  ;actualizo el tiempo
            
            call limpiar_pantalla1
            call movimiento_pelota
            call dibujar_pelota
            call mover_barra
            call dibujar_barra
            
            lea bx, fila1
            push bx
            mov ax, 0Ah
            call bloques
            call cambioColor

            lea bx, fila2
            push bx 
            mov ax, 17h
            call bloques
            call cambioColor

            lea bx, fila3
            push bx 
            mov ax, 24h
            call bloques
            call cambioColor

            lea bx, fila4
            push bx 
            mov ax, 31h
            call bloques
            call cambioColor

            lea bx, fila5
            push bx 
            mov ax, 3Eh
            call bloques
            call cambioColor

            lea bx, fila6
            push bx 
            mov ax, 4Bh
            call bloques
            call cambioColor

            jmp tiempo_partida
    tiempo_partida1 endp

    dibujar_pelota proc
        mov cx, pelota_x
        mov dx, pelota_y

        dibujo_horizontal:

            mov ah, 0ch ;escribir pixel
            mov al, 05h ;color magenta
            mov bh, 0   ; nro pagina
            int 10h
            inc cx 
            mov ax, cx
            sub ax, pelota_x
            cmp ax, pelota_tamanio
            jng dibujo_horizontal
            mov cx, pelota_x
            inc dx
            mov ax,dx
            sub ax,pelota_y
            cmp ax,pelota_tamanio
            jng dibujo_horizontal
        ret
    dibujar_pelota endp

    ;Cambia la variable color entre los valores 09h y 0Eh
    cambioColor proc
        add color, 01h
        cmp color, 0Eh
        ja resetearColor
        termina:
            ret
        resetearColor:
            mov color, 09h
            jmp termina
    cambioColor endp

    dibujar_barra proc
        mov cx, barra_x
        mov dx, barra_y

        dibujo_pixeles:
            mov ah, 0ch ;escribir pixel
            mov al, 03h ;color cyan
            mov bh, 0   ; nro pagina
            int 10h

            inc cx 
            mov ax, cx
            sub ax, barra_x
            cmp ax, barra_ancho
            jng dibujo_pixeles
            mov cx, barra_x
            inc dx
            mov ax,dx
            sub ax,barra_y
            cmp ax,barra_alto
            jng dibujo_pixeles
        ret
    dibujar_barra endp

    ;recibe por stack el offset de la lista de los bloques
    ;recibe en ax la altura en y donde empieza a dibujar
    bloques proc
        push bp
        mov bp, sp
        mov bx, ss:[bp+4]              ;el offset de la fila que voy a dibujar
        mov si, 0
        mov f_y, ax
        dibujaFila:
            cmp si, 7                  ;ya dibujo todos los bloques de esa fila
            je finFila
            mov cx, f_x
            mov dx, f_y                ;guardo la posicion inicial en dx para ir incrementando de a un pixel
            cmp byte ptr [bx + si], 0h ;si hay un cero no se dibuja el bloque
            jne dibujo_bloque

            incrementa:
                add f_x, 2Dh           ;dos pixeles mas del ancho de un bloque
                inc si
                jmp dibujaFila

            dibujo_bloque:
                mov ah, 0ch     ;escribir pixel
                mov al, color    
                mov bh, 0       ;nro pagina
                int 10h

                inc cx 
                mov ax, cx
                sub ax, f_x
                cmp ax, ancho_bloque
                jng dibujo_bloque
                mov cx, f_x     ;si ya termine de dibujar horizontalmente subo un pixel
                
                inc dx
                mov ax, dx
                sub ax, f_y
                cmp ax, alto_bloque
                jng dibujo_bloque
                jmp incrementa

            finFila:
                mov f_x, 02h ;vuelve f_x al valor original para la proxima vez que se llame a la funcion
                pop bp
                ret 2
    bloques endp 

    movimiento_pelota proc

        mov ax, pelota_velx
        add pelota_x, ax
        
        mov ax, ventana_limite
        cmp pelota_x, ax
        jl volver_x

        mov ax, ventana_ancho
        sub ax, pelota_tamanio
        sub ax, ventana_limite
        cmp pelota_x, ax
        jg volver_x

        mov ax,pelota_vely
        add pelota_y, ax
        
        cmp pelota_y,00h
        jl invertir

        mov ax,ventana_altura
        sub ax, pelota_tamanio
        sub ax, ventana_limite
        cmp pelota_y, ax
        jg resetear

        colision_barra: 
            mov ax, pelota_x
            add ax, pelota_tamanio
            cmp ax, barra_x
            jng salir

            mov ax, barra_x
            add ax, barra_ancho
            cmp pelota_x,ax
            jnl salir

            mov ax, pelota_y
            add ax, pelota_tamanio
            cmp ax, barra_y
            jng salir

            mov ax, barra_y
            add ax, barra_alto
            cmp pelota_y,ax
            jnl salir

            ; si no se cumple todo lo anterior, quiere decir que colisiono con la barra

            neg pelota_vely  
            ret
            volver_x:
                neg pelota_velx
            ret
            resetear:
                
                dec vidas
                cmp vidas, 30h
                je endGame
                call pausa 
                call resetear_pelota_y_barra
                cmp bloque_f,0
                ja invertir 
                jmp salir

            invertir:
                neg pelota_vely
                jmp salir
            endGame:
                call fin_juego
            reiniciar:
                mov ah,8         ;pide tecla
                int 21h
                cmp al,1bh
                jne reiniciar
            final:
                mov ax, 4c00h
                int 21h
        salir:

        lea bx,fila1
        push bx
        mov f_y, 15h
        call colision_bloques

        lea bx,fila2
        push bx
        mov f_y, 22h
        call colision_bloques

        lea bx,fila3
        push bx
        mov f_y, 2fh
        call colision_bloques

        lea bx,fila4
        push bx
        mov f_y, 3ch
        call colision_bloques

        lea bx,fila5
        push bx
        mov f_y, 49h
        call colision_bloques

        lea bx,fila6
        push bx
        mov f_y, 56h
        call colision_bloques

        ret
    movimiento_pelota endp
        
        ;Funcion que espera hasta que el usuario apriete enter
        ;para que el juego siga en curso,

    pausa proc
            
        mov ah, 9
        lea dx, cartelVidas
        int 21h
        mov ah, 9
        lea dx, vidas
        int 21h 
        pideTecla:
            mov ah,8         ;pide tecla
            int 21h
            cmp al,0dh       ;compara con enter
            jne pideTecla    ;hasta que no se apriete enter no hay ret
       
            ret
    pausa endp


    colision_bloques proc  
        push bp
        mov bp, sp
        mov bx, ss:[bp+4] 
        mov si,0
        verifico:
            cmp si,7
            je fin
            cmp byte ptr[bx+si], 0h
            je sigo
        verifico_posible_colision:
            mov ax, pelota_x
            add ax, pelota_tamanio
            cmp ax, f_x
            jng sigo

            mov ax, f_x
            add ax, ancho_bloque
            cmp pelota_x,ax
            jnl sigo

            mov ax, pelota_y
            add ax, pelota_tamanio
            cmp ax, f_y
            jng sigo

            mov ax, f_y
            add ax, alto_bloque
            cmp pelota_y,ax
            jnl sigo
            ; si no se cumple todo lo anterior, quiere decir que colisiono con el bloque
        colisiono:
            neg pelota_vely
            mov byte ptr[bx+si], 0h
            inc word ptr [score]
            cmp word ptr [score], 42 ; Comparar el score con 42 para saber si se rompieron todos los ladrillos
            jne sigo
        victoria:
            call win
        sigo:
            add f_x, 2dh
            inc si
            jmp verifico
        fin:
            mov f_x, 02h ;vuelve f_x al valor original para la proxima vez que se llame a la funcion
            pop bp
    ret 2
    colision_bloques endp

    resetear_pelota_y_barra proc
        ;; reseteo la pelota 
        mov ax, 8ch
        mov pelota_x, ax

        mov ax, 78h
        mov pelota_y, ax

        ;; reseteo la barra
        mov ax, 87h
        mov barra_x, ax

        mov ax, 0b4h
        mov barra_y, ax
       
    ret
    resetear_pelota_y_barra endp

    mover_barra proc
    
        mov ah,1
        int 16h
        jz verifico_mov_barra

        mov ah,0
        int 16h

        cmp al,64h
        je mover_barra_a_derecha
        cmp al,44h
        je mover_barra_a_derecha

        cmp al,61h
        je mover_barra_a_izq
        cmp al,41h
        je mover_barra_a_izq

        jmp verifico_mov_barra

        mover_barra_a_derecha:
            mov ax, barra_vel
            add barra_x,ax
            mov ax, ventana_ancho
            sub ax, ventana_limite
            sub ax, barra_ancho
            cmp barra_x, ax
            jg  limite_barra
            jmp verifico_mov_barra

        mover_barra_a_izq:
            mov ax, barra_vel
            sub barra_x,ax

            mov ax, ventana_limite
            cmp barra_x, ax
            jl  limite_barra
            jmp verifico_mov_barra
            
            limite_barra:
            mov barra_x,ax
            jmp verifico_mov_barra

        verifico_mov_barra:
    ret
    mover_barra endp

    
    limpiar_pantalla proc
        mov ah, 0  ; modo video
        mov al, 13h ; 320x200 la ventana
        int 10h

        mov ah, 0bh ;funcion fondo del borde
        mov bh, 00h ;
        mov bl, 1h ; color negro
        int 10h
    ret
    limpiar_pantalla endp


    fin_juego proc
        mov ah, 9
        lea dx, LOSE_MSG
        int 21h
        call imprimir_score
    ret 
    fin_juego endp

    imprimir_score proc
        
        push ax
        push bx
        push cx
        push dx

        ; Convertir el valor del score a una cadena de caracteres
        mov bx, 10 ; Base decimal
        mov cx, 0 ; Contador de dígitos
        mov ax, [score]
        cmp ax, 0 ; Verificar si el score es cero
        jg score_no_es_cero

        ; Si el score es cero, imprimir un dígito cero
        mov dx, '0'
        mov ah, 2 
        int 21h
        jmp imprimir_score_fin

    score_no_es_cero:
        mov bx, 10 
        mov cx, 0 
        mov dx, 0 ; DX es usado para construir la cadena
        score_loop:
            xor dx, dx
            div bx ; Dividir por 10
            add dl, '0' ; Convertir el dígito en un carácter ASCII
            push dx ; Apilar el digito convertido
            inc cx ; Incrementar el contador de digitos
            test ax, ax ; Verificar si queda algun digito
            jnz score_loop

        ; Imprimir los dígitos en orden inverso
        score_imprimir_loop:
            pop dx ; Obtener el digito de la pila
            mov ah, 2 ; Función para imprimir carácter
            int 21h
            loop score_imprimir_loop

    imprimir_score_fin:
        pop dx
        pop cx
        pop bx
        pop ax
    ret

    imprimir_score endp

    win proc

    mov ah, 9
    lea dx, WIN_MSG
    int 21h
    mov ah, 8
    int 21h
    mov ax, 4c00h
    int 21h
    win endp

    end