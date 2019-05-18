; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018
; Este programa deve esperar o usu�rio pressionar uma chave.
; Caso o usu�rio pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara��es EQU - Defines
; Declara��es EQU - Defines
PQ0		EQU		2_00001111
PQ1		EQU		2_00000110
PQ2		EQU		2_00001011
PQ3		EQU		2_00001111
PQ4		EQU		2_00000110
PQ5		EQU		2_00001101
PQ6		EQU		2_00001101
PQ7		EQU		2_00000111
PQ8		EQU		2_00001111
PQ9		EQU		2_00001111

PA0		EQU		2_00110000
PA1		EQU		2_00000000
PA2		EQU		2_01010000
PA3		EQU		2_01000000
PA4		EQU		2_01100000
PA5		EQU		2_01100000
PA6		EQU		2_01110000
PA7		EQU		2_00000000
PA8		EQU		2_01110000
PA9		EQU		2_01100000

; ========================
; Defini��es de Valores
; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA 	DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi��o da RAM		

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun��o Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma fun��o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; fun��o <func>
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT  GPIO_Init
        IMPORT  PortK_Output
		IMPORT  PortQ_Output
		IMPORT  PortB_Output
		IMPORT  PortM_Output
		IMPORT  PortJ_Input


; -------------------------------------------------------------------------------
; Fun��o main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	BL Inicializa_LCD
	
fim
	B fim

;--------------------------------------------------------------------------------
; Fun��o Inicializa_LCD
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem

Inicializa_LCD
	PUSH {LR}
	MOV R0, #15				; espera por 15ms
	BL SysTick_Wait1ms
	
	MOV R0, #2_00000000		; RS = 0, RW = 0, EN = 0
	BL PortM_Output			; limpa os pinos de comando

	MOV R0, #0x38
	BL Instrucoes_LCD
	
	MOV R0, #0x06
	BL Instrucoes_LCD
	
	MOV R0, #0x0F
	BL Instrucoes_LCD
	
	MOV R0, #0x01
	BL Instrucoes_LCD
	
	POP {LR}
	BX LR

;--------------------------------------------------------------------------------
; Fun��o Instru��es_LCD
; Par�metro de entrada: R0 -> C�digo de instru��o
; Par�metro de sa�da: N�o tem

Instrucoes_LCD

	PUSH {LR}
	
	BL PortK_Output			; escreve comando no barramento de dados
	
	MOV R0, #2_00000100		; RS = 0, RW = 0, EN = 1
	BL PortM_Output			; ativa enable para que o comando seja executado
	MOV R0, #10				; espera por 10ms at� que o LCD esteja pronto
	BL SysTick_Wait1ms
	
	MOV R0, #2_00000000		; RS = 0, RW = 0, EN = 0
	BL PortM_Output			; desativa enable ap�s utiliza��o
	
	POP {LR}
	BX LR

;--------------------------------------------------------------------------------
; Fun��o Escrita_LCD
; Par�metro de entrada: R0 -> Dado a ser enviado
; Par�metro de sa�da: N�o tem

Escrita_LCD
	PUSH {LR}
	
	BL PortK_Output			; escreve o dado no barramento
	
	MOV R0, #2_00000101		; RS = 1, RW = 0, EN = 1
	BL PortM_Output			; ativa enable e RS para que o dado seja escrito
	MOV R0, #10				; espera por 10ms at� que o LCD esteja pronto
	BL SysTick_Wait1ms
	
	MOV R0, #2_00000000		; RS = 0, RW = 0, EN = 0
	BL PortM_Output			; desativa enable ap�s utiliza��o
	
	POP {LR}
	BX LR

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
