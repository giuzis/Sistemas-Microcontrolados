; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018
; Este programa deve esperar o usuário pressionar uma chave.
; Caso o usuário pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declarações EQU - Defines
; Declarações EQU - Defines
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
; Definições de Valores
; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA 	DATA, ALIGN=2
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
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT  GPIO_Init
        IMPORT  PortA_Output
		IMPORT  PortQ_Output
		IMPORT  PortB_Output
		IMPORT  PortM_Output
		IMPORT  PortJ_Input


; -------------------------------------------------------------------------------
; Função main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO

; R5 é o contador
; R6 é o passo
; R11 flag que diz se o botão SW1 está apertado (1) ou não (0)
; R10 flag que diz se o botão SW2 está apertado (1) ou não (0)
; R9 contador interno
	MOV R10, #0
	MOV R11, #0
	MOV R6, #1		;Inicia com passo 1
	MOV R12, #1		;Contador para os LEDs
MainLoop
	MOV R5, #0		;Inicia a contagem em 0
Contagem
	MOV R9, #0
Mostra_1s
	CMP R11, #1
	BLEQ Acrescenta_Contador
	CMP R10, #1
	BLEQ Decrementa_Contador
	
	MOV R0, R5
	BL Mostra_Numero
	CMP R11, #0
	BLEQ Le_Botao_SW1
	CMP R10, #0
	BLEQ Le_Botao_SW2
	ADD R9, #1
	CMP R9, #100
	BNE Mostra_1s
	
	ADD R12, #1
	ADD R5, R6
	CMP R5, #99
	BGT MainLoop
	B Contagem
	

;--------------------------------------------------------------------------------
; Função Acrescenta_Contador
; Parâmetro de entrada: R6 -> passo de contagem
; Parâmetro de saída: R6 -> incrementado em um
Acrescenta_Contador
	PUSH {LR}
	BL Le_Botao_SW1
	POP {LR}
	CMP R11, #0
	BNE Fim_Acrescenta_Contador
	CMP R6, #9
	BEQ Fim_Acrescenta_Contador
	ADD R6, #1
Fim_Acrescenta_Contador
	BX LR
	
;--------------------------------------------------------------------------------
; Função Decrementa_Contador
; Parâmetro de entrada: R6 -> passo de contagem
; Parâmetro de saída: R6 -> decrementado em um
Decrementa_Contador
	PUSH {LR}
	BL Le_Botao_SW2
	POP {LR}
	CMP R10, #0
	BNE Fim_Decrementa_Contador
	CMP R6, #1
	BEQ Fim_Decrementa_Contador
	SUB R6, #1
Fim_Decrementa_Contador
	BX LR

;--------------------------------------------------------------------------------
; Função Mostra_Numero
; Parâmetro de entrada: R0 -> número a ser escrito no display
; Parâmetro de saída: Não tem
Mostra_Numero
	MOV R1, #10
	UDIV R1, R0, R1		; R1 tem o algarismo da dezena
	MOV R2, #10
	MUL R2, R1, R2
	SUB R2, R0, R2
	MOV R0, R2			; R0 tem o algarismo da unidade
	MOV R7, R1			; R7 tem o algarismo da dezena
	PUSH {LR}
	
	BL Acende_Display_Unidade
	MOV R0, #5
	BL SysTick_Wait1ms
	BL Apaga_Display
	
	MOV R0, R7
	BL Acende_Display_Dezena
	MOV R0, #5
	BL SysTick_Wait1ms
	BL Apaga_Display
	
	BL Acende_LEDs
	MOV R0, #5
	BL SysTick_Wait1ms
	BL Apaga_LEDs
	POP {LR}
	BX LR

;--------------------------------------------------------------------------------
; Função Acende_Display_Unidade
; Parâmetro de entrada: R0 -> número a ser escrito no display
; Parâmetro de saída: Não tem
Acende_Display_Unidade
	PUSH {LR}
	BL Converte_Numero
	MOV R0, R8
	BL PortA_Output
	MOV R0, R8
	BL PortQ_Output
	MOV R0, #2_00100000
	BL PortB_Output
	MOV R0, #1
	BL SysTick_Wait1ms

	POP {LR}
	BX LR

;--------------------------------------------------------------------------------
; Função Acende_LEDs
; Parâmetro de entrada: R7 -> contador para os LEDs
; Parâmetro de saída: Não tem
Acende_LEDs
	PUSH {LR}
	BL Converte_LEDs
	CMP R12, #16
	BNE LEDs
	MOV R12, #0
LEDs
	MOV R8, R0
	BL PortA_Output
	MOV R0, R8
	BL PortQ_Output
	MOV R0, #2_01000000
	BL PortM_Output
	MOV R0, #1
	BL SysTick_Wait1ms

	POP {LR}
	BX LR

;--------------------------------------------------------------------------------
; Função Converte_LEDs
; Parâmetro de entrada: R12 -> número a ser convertido
; Parâmetro de saída: R0 -> sequência a ser escrita nos LEDs
Converte_LEDs
	CMP R12, #1
	BNE Dois_LEDs
	MOV R0, #2_00000001
	BX LR
Dois_LEDs
	CMP R12, #2
	BNE Tres_LEDs
	MOV R0, #2_00000011
	BX LR
Tres_LEDs
	CMP R12, #3
	BNE Quatro_LEDs
	MOV R0, #2_00000111
	BX LR
Quatro_LEDs
	CMP R12, #4
	BNE Cinco_LEDs
	MOV R0, #2_00001111
	BX LR
Cinco_LEDs
	CMP R12, #5
	BNE Seis_LEDs
	MOV R0, #2_00011111
	BX LR
Seis_LEDs
	CMP R12, #6
	BNE Sete_LEDs
	MOV R0, #2_00111111
	BX LR
Sete_LEDs
	CMP R12, #7
	BNE Oito_LEDs
	MOV R0, #2_01111111
	BX LR
Oito_LEDs
	CMP R12, #8
	BNE Nove_LEDs
	MOV R0, #2_11111111
	BX LR
Nove_LEDs
	CMP R12, #9
	BNE Dez_LEDs
	MOV R0, #2_11111110
	BX LR
Dez_LEDs
	CMP R12, #10
	BNE Onze_LEDs
	MOV R0, #2_11111100
	BX LR
Onze_LEDs
	CMP R12, #11
	BNE Doze_LEDs
	MOV R0, #2_11111000
	BX LR
Doze_LEDs
	CMP R12, #12
	BNE Treze_LEDs
	MOV R0, #2_11110000
	BX LR
Treze_LEDs
	CMP R12, #13
	BNE Quatorze_LEDs
	MOV R0, #2_11100000
	BX LR
Quatorze_LEDs
	CMP R12, #14
	BNE Quinze_LEDs
	MOV R0, #2_11000000
	BX LR
Quinze_LEDs
	CMP R12, #15
	BNE Dezesseis_LEDs
	MOV R0, #2_10000000
	BX LR
Dezesseis_LEDs
	MOV R0, #2_00000000
	BX LR
	

;--------------------------------------------------------------------------------
; Função Acende_Display_Dezena
; Parâmetro de entrada: R0 -> número a ser escrito no display
; Parâmetro de saída: Não tem
Acende_Display_Dezena
	PUSH {LR}
	BL Converte_Numero
	MOV R8, R0
	BL PortA_Output
	MOV R0, R8
	BL PortQ_Output
	MOV R0, #2_00010000
	BL PortB_Output
	MOV R0, #1
	BL SysTick_Wait1ms
	POP {LR}
	BX LR

;--------------------------------------------------------------------------------
; Função Apaga_Display
; Parâmetro de entrada: Não tem
; Parâmetro de saída: Não tem
Apaga_Display
	PUSH {LR}
	MOV R0, #2_00000000
	BL PortB_Output
	POP {LR}
	BX LR
	
;--------------------------------------------------------------------------------
; Função Apaga_LEDs
; Parâmetro de entrada: Não tem
; Parâmetro de saída: Não tem
Apaga_LEDs
	PUSH {LR}
	MOV R0, #2_00000000
	BL PortM_Output
	POP {LR}
	BX LR

;--------------------------------------------------------------------------------
; Função Converte_Numero
; Parâmetro de entrada: R0 -> número a ser escrito no display
; Parâmetro de saída: R0 -> npumer convertido para BCD
Converte_Numero
	CMP R0, #0
	BNE Um
	MOV R8, #2_00111111
	B Fim_Converte_Numero
Um
	CMP R0, #1
	BNE Dois
	MOV R8, #2_00000110
	B Fim_Converte_Numero
Dois
	CMP R0, #2
	BNE Tres
	MOV R8, #2_01011011
	B Fim_Converte_Numero
Tres
	CMP R0, #3
	BNE Quatro
	MOV R8, #2_01001111
	B Fim_Converte_Numero
Quatro
	CMP R0, #4
	BNE Cinco
	MOV R8, #2_01100110
	B Fim_Converte_Numero
Cinco
	CMP R0, #5
	BNE Seis
	MOV R8, #2_01101101
	B Fim_Converte_Numero
Seis
	CMP R0, #6
	BNE Sete
	MOV R8, #2_01111101
	B Fim_Converte_Numero
Sete
	CMP R0, #7
	BNE Oito
	MOV R8, #2_00000111
	B Fim_Converte_Numero
Oito
	CMP R0, #8
	BNE Nove
	MOV R8, #2_01111111
	B Fim_Converte_Numero
Nove
	CMP R0, #9
	BNE Apaga
	MOV R8, #2_01101111
	B Fim_Converte_Numero
Apaga
	MOV R8, #2_00000000
Fim_Converte_Numero
	MOV R0, R8
	BX LR

;--------------------------------------------------------------------------------
; Função Le_Botao_SW1
; Parâmetro de entrada: Não tem
; Parâmetro de saída: R11 -> se o botão está apertado (1) ou solto (0)

Le_Botao_SW1
	PUSH {LR}
	BL PortJ_Input
	POP {LR}
	CMP R0, #2_00000010
	BEQ Seta_SW1
	MOV R11, #0
	BX LR
Seta_SW1
	MOV R11, #1
	BX LR
	
;--------------------------------------------------------------------------------
; Função Le_Botao_SW2
; Parâmetro de entrada: Não tem
; Parâmetro de saída: R11 -> se o botão está apertado (1) ou solto (0)

Le_Botao_SW2
	PUSH {LR}
	BL PortJ_Input
	POP {LR}
	CMP R0, #2_00000001
	BEQ Seta_SW2
	MOV R10, #0
	BX LR
Seta_SW2
	MOV R10, #1
	BX LR
	
	
;--------------------------------------------------------------------------------
; Função Pisca_LED
; Parâmetro de entrada: Não tem
; Parâmetro de saída: Não tem
; Tem que fazer o LED piscar
;Pisca_LED
;	MOV R0, #2_00000001			 ;Setar o parâmetro de entrada da função como o BIT0
;	PUSH {LR}
;	BL PortF_Output				 ;Chamar a função para setar o LED4
;	MOV R0, #1000				 ; parâmetro da função SysTick_Wait1ms
;	BL SysTick_Wait1ms
;	MOV R0, #2_00000000
;	BL PortF_Output				 ;Chamar a função para desligar o LED4
;	MOV R0, #1000				 ; parâmetro da função SysTick_Wait1ms
;	BL SysTick_Wait1ms
;	POP {LR}
;	BX LR

; ****************************************
; Escrever função que acende o LED, espera 1 segundo, apaga o LED e espera 1 s
; Esta função deve chamar a rotina SysTick_Wait1ms com o parâmetro de entrada em R0
; ****************************************

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo
