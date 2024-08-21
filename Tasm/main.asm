.8086
.model small
.stack 100h

.data
    
.code

    extrn limpiar_pantalla:proc
    extrn tiempo_partida1:proc
    extrn msj_bienvenida:proc
    extrn menu:proc

    main proc 
        mov ax, @data
        mov ds, ax

        call msj_bienvenida
        call menu
        call limpiar_pantalla
        call tiempo_partida1
    main endp
end
