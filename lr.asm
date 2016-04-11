;Написать подпрограмму выделения из исходной строки подстроки символов заданной длинны с указанного номера позиции, Pascal-string
.model small
.stack 256
.data 
test1 db 20,'Bring me the Horizon'
test_n db 2
test_l db 4
res db $-test1-2 dup (?)
.code
start:
mov ax,@data
mov ds,ax
mov es,ax

lea si,test1
xor cx,cx
mov cl,[si]
;запись подстроки
xor cx,cx
mov  cl,[test_l]; 
mov bx,cx; передаём чрез bx значение cx
MOV AH,00
mov al,test_n
lea si,test1
ADD SI,AX ;установка в исходную позицию
LEA DI,res ;начало строки результата
MOV [DI],CX ;формирование Pascal-string
INC DI
call SubString
;вывод результата
LEA DI,res
MOV BL,[DI]
MOV BH,00
;передаём чрез bx значение cx
INC DI
call Output
;установка ожидания вода символа с клавиатуры для просмотра результатов
mov ah,01h 
int 21h
;стандартная процедура выхода
MOV AX,4C00h
INT 21h
;---------------------------------------
	SubString Proc
	mov cx,bx; вот твоя передача
	m2:
		MOV AX,[SI]
		MOV [DI],AX ;перезапись 1 байта
		INC SI
		INC DI 
		LOOP m2
	ret
	endp
;---------------------------------------
	Output Proc
	mov cx,bx; вот твоя передача
	m3: 
		MOV AH,02h ;запрос на вывод на экран
		MOV DL,[DI]
		INT 21h ;запрос прерывания на вывод символа
		INC DI
	LOOP m3
	ret
	endp
end start