; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
; ========================
; Defini��es de Valores
BIT0	EQU 2_0001
BIT1	EQU 2_0010
; ========================
; Defini��es dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
; Defini��es dos Ports
; PORT M
GPIO_PORTM_AHB_LOCK_R    	EQU    0x40063520
GPIO_PORTM_AHB_CR_R      	EQU    0x40063524
GPIO_PORTM_AHB_AMSEL_R   	EQU    0x40063528
GPIO_PORTM_AHB_PCTL_R    	EQU    0x4006352C
GPIO_PORTM_AHB_DIR_R     	EQU    0x40063400
GPIO_PORTM_AHB_AFSEL_R   	EQU    0x40063420
GPIO_PORTM_AHB_DEN_R     	EQU    0x4006351C
GPIO_PORTM_AHB_PUR_R     	EQU    0x40063510	
GPIO_PORTM_AHB_DATA_R    	EQU    0x400633FC
GPIO_PORTM               	EQU    2_000100000000000
; PORT K
GPIO_PORTK_AHB_LOCK_R    	EQU    0x40061520
GPIO_PORTK_AHB_CR_R      	EQU    0x40061524
GPIO_PORTK_AHB_AMSEL_R   	EQU    0x40061528
GPIO_PORTK_AHB_PCTL_R    	EQU    0x4006152C
GPIO_PORTK_AHB_DIR_R     	EQU    0x40061400
GPIO_PORTK_AHB_AFSEL_R   	EQU    0x40061420
GPIO_PORTK_AHB_DEN_R     	EQU    0x4006151C
GPIO_PORTK_AHB_PUR_R     	EQU    0x40061510	
GPIO_PORTK_AHB_DATA_R    	EQU    0x400613FC
GPIO_PORTK               	EQU    2_000001000000000
; PORT J
GPIO_PORTJ_AHB_LOCK_R    	EQU    0x40060520
GPIO_PORTJ_AHB_CR_R      	EQU    0x40060524
GPIO_PORTJ_AHB_AMSEL_R   	EQU    0x40060528
GPIO_PORTJ_AHB_PCTL_R    	EQU    0x4006052C
GPIO_PORTJ_AHB_DIR_R     	EQU    0x40060400
GPIO_PORTJ_AHB_AFSEL_R   	EQU    0x40060420
GPIO_PORTJ_AHB_DEN_R     	EQU    0x4006051C
GPIO_PORTJ_AHB_PUR_R     	EQU    0x40060510	
GPIO_PORTJ_AHB_DATA_R    	EQU    0x400603FC
GPIO_PORTJ               	EQU    2_000000100000000
; PORT F
GPIO_PORTF_AHB_LOCK_R    	EQU    0x4005D520
GPIO_PORTF_AHB_CR_R      	EQU    0x4005D524
GPIO_PORTF_AHB_AMSEL_R   	EQU    0x4005D528
GPIO_PORTF_AHB_PCTL_R    	EQU    0x4005D52C
GPIO_PORTF_AHB_DIR_R     	EQU    0x4005D400
GPIO_PORTF_AHB_AFSEL_R   	EQU    0x4005D420
GPIO_PORTF_AHB_DEN_R     	EQU    0x4005D51C
GPIO_PORTF_AHB_PUR_R     	EQU    0x4005D510	
GPIO_PORTF_AHB_DATA_R    	EQU    0x4005D3FC
GPIO_PORTF               	EQU    2_000000000100000	
; PORT A
GPIO_PORTA_AHB_LOCK_R    	EQU    0x40058520
GPIO_PORTA_AHB_CR_R      	EQU    0x40058524
GPIO_PORTA_AHB_AMSEL_R   	EQU    0x40058528
GPIO_PORTA_AHB_PCTL_R    	EQU    0x4005852C
GPIO_PORTA_AHB_DIR_R     	EQU    0x40058400
GPIO_PORTA_AHB_AFSEL_R   	EQU    0x40058420
GPIO_PORTA_AHB_DEN_R     	EQU    0x4005851C
GPIO_PORTA_AHB_PUR_R     	EQU    0x40058510	
GPIO_PORTA_AHB_DATA_R    	EQU    0x400583FC
GPIO_PORTA               	EQU    2_000000000000001	
; PORT Q
GPIO_PORTQ_AHB_LOCK_R    	EQU    0x40066520
GPIO_PORTQ_AHB_CR_R      	EQU    0x40066524
GPIO_PORTQ_AHB_AMSEL_R   	EQU    0x40066528
GPIO_PORTQ_AHB_PCTL_R    	EQU    0x4006652C
GPIO_PORTQ_AHB_DIR_R     	EQU    0x40066400
GPIO_PORTQ_AHB_AFSEL_R   	EQU    0x40066420
GPIO_PORTQ_AHB_DEN_R     	EQU    0x4006651C
GPIO_PORTQ_AHB_PUR_R     	EQU    0x40066510	
GPIO_PORTQ_AHB_DATA_R    	EQU    0x400663FC
GPIO_PORTQ               	EQU    2_100000000000000	
; PORT B
GPIO_PORTB_AHB_LOCK_R    	EQU    0x40059520
GPIO_PORTB_AHB_CR_R      	EQU    0x40059524
GPIO_PORTB_AHB_AMSEL_R   	EQU    0x40059528
GPIO_PORTB_AHB_PCTL_R    	EQU    0x4005952C
GPIO_PORTB_AHB_DIR_R     	EQU    0x40059400
GPIO_PORTB_AHB_AFSEL_R   	EQU    0x40059420
GPIO_PORTB_AHB_DEN_R     	EQU    0x4005951C
GPIO_PORTB_AHB_PUR_R     	EQU    0x40059510	
GPIO_PORTB_AHB_DATA_R    	EQU    0x400593FC
GPIO_PORTB               	EQU    2_000000000000010	

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
		EXPORT PortQ_Output			; Permite chamar PortF_Output de outro arquivo
		EXPORT PortK_Output          ; Permite chamar PortJ_Input de outro arquivo
		EXPORT PortB_Output          ; Permite chamar PortJ_Input de outro arquivo
		EXPORT PortJ_Input          ; Permite chamar PortJ_Input de outro arquivo
		EXPORT PortM_Output          ; Permite chamar PortJ_Input de outro arquivo
		EXPORT PortM_Input          ; Permite chamar PortJ_Input de outro arquivo
									

;--------------------------------------------------------------------------------
; Fun��o GPIO_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
GPIO_Init
;=====================
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; ap�s isso verificar no PRGPIO se a porta est� pronta para uso.
; enable clock to GPIOF at clock gating register
            LDR     R0, =SYSCTL_RCGCGPIO_R  		;Carrega o endere�o do registrador RCGCGPIO
			MOV		R1, #GPIO_PORTK                 ;Seta o bit da porta F
;			ORR     R1, #GPIO_PORTQ					;Seta o bit da porta J, fazendo com OR
;			ORR     R1, #GPIO_PORTB					;Seta o bit da porta J, fazendo com OR
;           ORR     R1, #GPIO_PORTJ					;Seta o bit da porta J, fazendo com OR
			ORR     R1, #GPIO_PORTM					;Seta o bit da porta J, fazendo com OR
            STR     R1, [R0]						;Move para a mem�ria os bits das portas no endere�o do RCGCGPIO
 
            LDR     R0, =SYSCTL_PRGPIO_R			;Carrega o endere�o do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO  LDR     R1, [R0]						;L� da mem�ria o conte�do do endere�o do registrador
			MOV     R2, #GPIO_PORTK                 ;Seta os bits correspondentes �s portas para fazer a compara��o
;			ORR     R2, #GPIO_PORTQ                 ;Seta o bit da porta J, fazendo com OR
;			ORR     R2, #GPIO_PORTB					;Seta o bit da porta J, fazendo com OR
;           ORR     R2, #GPIO_PORTJ					;Seta o bit da porta J, fazendo com OR
			ORR     R2, #GPIO_PORTM					;Seta o bit da porta J, fazendo com OR
            TST     R1, R2							;ANDS de R1 com R2
            BEQ     EsperaGPIO					    ;Se o flag Z=1, volta para o la�o. Sen�o continua executando
 
; 2. Limpar o AMSEL para desabilitar a anal�gica
            MOV     R1, #0x00						;Colocar 0 no registrador para desabilitar a fun��o anal�gica
            LDR     R0, =GPIO_PORTK_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
;           LDR     R0, =GPIO_PORTJ_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
;           STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
;           LDR     R0, =GPIO_PORTQ_AHB_AMSEL_R		;Carrega o R0 com o endere�o do AMSEL para a porta F
;           STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta F da mem�ria
;			LDR     R0, =GPIO_PORTB_AHB_AMSEL_R		;Carrega o R0 com o endere�o do AMSEL para a porta F
;           STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta F da mem�ria
			LDR     R0, =GPIO_PORTM_AHB_AMSEL_R		;Carrega o R0 com o endere�o do AMSEL para a porta F
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta F da mem�ria
 
; 3. Limpar PCTL para selecionar o GPIO
            MOV     R1, #0x00					    ;Colocar 0 no registrador para selecionar o modo GPIO
            LDR     R0, =GPIO_PORTK_AHB_PCTL_R		;Carrega o R0 com o endere�o do PCTL para a porta J
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta J da mem�ria
;            LDR     R0, =GPIO_PORTJ_AHB_PCTL_R		;Carrega o R0 com o endere�o do PCTL para a porta J
;            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta J da mem�ria
;            LDR     R0, =GPIO_PORTQ_AHB_PCTL_R      ;Carrega o R0 com o endere�o do PCTL para a porta F
;            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta F da mem�ria
;			LDR     R0, =GPIO_PORTB_AHB_PCTL_R      ;Carrega o R0 com o endere�o do PCTL para a porta F
;            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta F da mem�ria
			LDR     R0, =GPIO_PORTM_AHB_PCTL_R      ;Carrega o R0 com o endere�o do PCTL para a porta F
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta F da mem�ria
			
; 4. DIR para 0 se for entrada, 1 se for sa�da
;           LDR     R0, =GPIO_PORTA_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta F
;			MOV     R1, #0XF0						;Colocar 0 no registrador DIR para funcionar com sa�da
;            STR     R1, [R0]						;Guarda no registrador
			LDR     R0, =GPIO_PORTK_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta F
			MOV     R1, #0XFF						;Colocar 0 no registrador DIR para funcionar com sa�da
            STR     R1, [R0]						;Guarda no registrador
			; O certo era verificar os outros bits da PF para n�o transformar entradas em sa�das desnecess�rias
;            LDR     R0, =GPIO_PORTQ_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
;            MOV     R1, #0x0F               		;Colocar 0 no registrador DIR para funcionar com sa�da
;            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
;			LDR     R0, =GPIO_PORTJ_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
;            MOV     R1, #0x00               		;Colocar 0 no registrador DIR para funcionar com sa�da
;            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
;			LDR     R0, =GPIO_PORTB_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
;            MOV     R1, #0x30               		;Colocar 0 no registrador DIR para funcionar com sa�da
;            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
			LDR     R0, =GPIO_PORTM_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
            MOV     R1, #0x07               		;Colocar 0 no registrador DIR para funcionar com sa�da 01000000
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
; 5. Limpar os bits AFSEL para 0 para selecionar GPIO 
;    Sem fun��o alternativa
            MOV     R1, #0x00						;Colocar o valor 0 para n�o setar fun��o alternativa
            LDR     R0, =GPIO_PORTK_AHB_AFSEL_R		;Carrega o endere�o do AFSEL da porta F
            STR     R1, [R0]						;Escreve na porta
;            LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R		;Carrega o endere�o do AFSEL da porta F
;            STR     R1, [R0]						;Escreve na porta
;            LDR     R0, =GPIO_PORTQ_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
;            STR     R1, [R0]                        ;Escreve na porta
;			LDR     R0, =GPIO_PORTB_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
;            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTM_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
            STR     R1, [R0]                        ;Escreve na porta
; 6. Setar os bits de DEN para habilitar I/O digital
            LDR     R0, =GPIO_PORTK_AHB_DEN_R			;Carrega o endere�o do DEN
            MOV     R1, #2_11111111                     ;Ativa os pinos PA4 a PA7 como I/O Digital
            STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital 
 
;            LDR     R0, =GPIO_PORTQ_AHB_DEN_R			;Carrega o endere�o do DEN
;			MOV     R1, #2_00001111                     ;Ativa os pinos PQ0 a PQ3 como I/O Digital      
;            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
			
;			LDR     R0, =GPIO_PORTB_AHB_DEN_R			;Carrega o endere�o do DEN
;			MOV     R1, #2_00110000                     ;Ativa os pinos PQ0 a PQ3 como I/O Digital      
;            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
            
;			LDR     R0, =GPIO_PORTJ_AHB_DEN_R			;Carrega o endere�o do DEN
;			MOV     R1, #2_00000011                     ;Ativa os pinos PQ0 a PQ3 como I/O Digital      
;            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
			
			LDR     R0, =GPIO_PORTM_AHB_DEN_R			;Carrega o endere�o do DEN
			MOV     R1, #2_00000111                     ;Ativa os pinos PQ0 a PQ3 como I/O Digital      
            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
; 7. Para habilitar resistor de pull-up interno, setar PUR para 1
;			LDR     R0, =GPIO_PORTJ_AHB_PUR_R			;Carrega o endere�o do PUR para a porta J
;			MOV     R1, #2_00000011						;Habilitar funcionalidade digital de resistor de pull-up 
                                                        ;nos bits 0 e 1
;            STR     R1, [R0]							;Escreve no registrador da mem�ria do resistor de pull-up
            
            
;retorno            
			BX      LR

; -------------------------------------------------------------------------------
; Fun��o PortA_Output
; Par�metro de entrada: R0 --> dados de entrada no LCD
; Par�metro de sa�da: N�o tem

PortK_Output
			LDR	R1, =GPIO_PORTK_AHB_DATA_R		    ;Carrega o valor do offset do data register
			;Read-Modify-Write para escrita
			LDR R2, [R1]
			BIC R2, #2_11111111                     ;Primeiro limpamos o bit do lido da porta R3 = R3 & 11111110
			ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
			STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F0
			BX LR

; Fun��o PortA_Output
; Par�metro de entrada: R0 --> se os BIT0 est�o ligado ou desligado
; Par�metro de sa�da: N�o tem

PortB_Output
			LDR	R1, =GPIO_PORTB_AHB_DATA_R		    ;Carrega o valor do offset do data register
			;Read-Modify-Write para escrita
			LDR R2, [R1]
			BIC R2, #2_00110000                     ;Primeiro limpamos o bit do lido da porta R3 = R3 & 11111110
			ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
			STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F0
			BX LR

; -------------------------------------------------------------------------------
; Fun��o PortQ_Output
; Par�metro de entrada: R0 --> se os BIT0 est�o ligado ou desligado
; Par�metro de sa�da: N�o tem

PortQ_Output
			LDR	R1, =GPIO_PORTQ_AHB_DATA_R		    ;Carrega o valor do offset do data register
			;Read-Modify-Write para escrita
			LDR R2, [R1]
			BIC R2, #2_00001111                     ;Primeiro limpamos o bit do lido da porta R3 = R3 & 11111110
			ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
			STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F0
			BX LR

; -------------------------------------------------------------------------------
; Fun��o PortM_Output
; Par�metro de entrada: R0 --> Controla EN, R/W e R
; Par�metro de sa�da: N�o tem
PortM_Output
			LDR	R1, =GPIO_PORTM_AHB_DATA_R		    ;Carrega o valor do offset do data register
			;Read-Modify-Write para escrita
			LDR R2, [R1]
			BIC R2, #2_00000111                     ;Primeiro limpamos o bit do lido da porta R3 = R3 & 11111110
			ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
			STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F0
			BX LR
			
; -------------------------------------------------------------------------------
; Fun��o PortJ_Input
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: R0 --> o valor da leitura
PortJ_Input
			LDR	R1, =GPIO_PORTJ_AHB_DATA_R		    ;Carrega o valor do offset do data register
			;Read-Modify-Write para escrita
			LDR R0, [R1]							;Carrega em R0 o valor da leitura da porta J
			BX LR

; -------------------------------------------------------------------------------
; Fun��o PortM_Input
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: R0 --> o valor da leitura
PortM_Input
			LDR	R1, =GPIO_PORTM_AHB_DATA_R		    ;Carrega o valor do offset do data register
			;Read-Modify-Write para escrita
			LDR R0, [R1]							;Carrega em R0 o valor da leitura da porta J
			BX LR
			

    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo