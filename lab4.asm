.model small
.stack 100h

.data
   maxi db 05h
   char db "m"    ; the character to guess
   less db 0ah,0dh,'Oops ! It is smaller ','$'
   more db 0ah,0dh,'Oops! It is larger ','$'
   equal db 0ah,0dh,'Yay!!  Finally!! ','$'
   win db 0ah,0dh,'Wow! You won!  ','$'
   lose db 0ah,0dh,'Sorry! You took more than required turns ','$'
.code

begin :
  mov ax,@data
  mov ds,ax
  
  
  mov cl,00h    ; Number of turns to be stored in cl
  mov bl,maxi   ; the max turns expected for victory stored in bl
  
 take :
    inc cl
    mov ah,01h   ;inputs one character
	int 21h     ;  input is stored in dl 
	cmp al,char   ; compare character in al with char
	je last     ; if equal , jump to last
	jg larger    ; if larger, jump to larger
	mov dx,offset less   ; in case of smaller, dx is set to the less string of data segment
	mov ah,09   ; output character stored in dx
    int 21h  
	jmp take    ; jump to take again
	
larger :
   mov dx,offset more   ; in case of larger, dx is set to the more string of data segment
	mov ah,09   ; output character stored in dx
    int 21h  
   jmp take     ; jump to take
last :
    mov dx,offset equal  ; in case of equal, dx is set to the equal string of data segment
	mov ah,09   ; output character stored in dx
    int 21h
    cmp cl,bl      ; to decide win or loss, compare cl with bl , cl contains total moves , bl contains expected moves
	jg lost     ; jump to lost of cl > bl
    jmp won     ; jump to won otherwise ,i.e. less or equal moves than expected
won :
    mov dx,offset win    ; in case of win, dx is set to the win string of data segment
	mov ah,09   ; output character stored in dx
    int 21h
	jmp halt   ; end of the program after win
lost :
   mov dx,offset lose   ; in case of loss, dx is set to the lose string of data segment
	mov ah,09   ; output character stored in dx
    int 21h
halt : mov ah,4ch    ; exit codes
  int 21h
  end begin
  
  
  