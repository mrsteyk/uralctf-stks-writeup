format PE CONSOLE
entry start

section '.code' executable readable writeable
start:
    mov esi, a
    mov ecx, 0Fh ; size in words

    mov eax, 03h ; initial key

    GLP:
    xor word [esi], ax
    sub byte [esi], 0ah
    sub byte [esi+1], 0fh
    xor word [esi], ax

    mov edx, 13h
    mul dx

    add ax, 523h
    add si, 2
    loop GLP

    sub esp, 8
    push aform
    push a
    call dword [printf]
    ret

a  db 0x63, 0x81, 0x1B, 0x7D, 0x49, 0x27, 0x30, 0x68, 0x58, 0x5C, 0x51, 0x8B, 0x61, 0x5A, 0x7E, 0xAE, 0x97, 0x62, 0x51, 0x70, 0x7D, 0x22, 0x4D, 0x01, 0x9B, 0x74, 0x47, 0x3F, 0x0D, 0x0A, 0x00
aform db "%s"

section '.idata' import data readable writeable
dd 0,0,0,RVA msvcrt,RVA m_table
dd 0,0,0,0,0

m_table:
  printf dq RVA _printf
  dq 0
msvcrt db 'msvcrt.dll',0
_printf dw 0
   db 'printf',0