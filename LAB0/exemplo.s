; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>

; -------------------------------------------------------------------------------
; Função main()
Start  
			
;loop_ext:
;			mov ram, #0x20000000
;			mov tam, #10
;			mov troca, #0
;			mov i, #1
;			
;loop_int:
;			ldr comp, [ram]
;			ldr compv, [ram, #8]
;			cmp comp, compv
;			ittt	gt	
;				movgt troca,#1
;				strgt compv, [ram]
;				strgt comp, [ram, #8]!
;			add i, #1
;			cmp i, tam
;			bne loop_int
;			cmp troca, #0
;			bne	loop_ext

; r0 = ram
; r1 = tam
; r2 = troca
; r3 = i
; r4 = comp
; r5 = compv
			
loop_ext
			mov r0, #0x20000000
			mov r1, #10
			mov r2, #0
			mov r3, #1
			
loop_int
			ldrb r4, [r0]
			ldrb r5, [r0, #1]
			cmp r4, r5
			ittt	gt	
				movgt r2,#1
				strbgt r5, [r0]
				strbgt r4, [r0, #1]
			add r0, #1
			add r3, #1
			cmp r3, r1
			bne loop_int
			cmp r2, #0
			bne	loop_ext
			
	nop
    ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo
