    global _main

    extern _GetStdHandle@4
    extern _WriteFile@20
    extern _ExitProcess@4

    section .text
_main:
    mov     ebp, esp
    sub     esp, 4

    ; hStdOut GetStdHandle( STD_OUTPUT_HANDLE )
    push    -11
    call    _GetStdHandle@4
    mov     ebx, eax

    ; BYTE WriteFile(
        ; _IN_          HANDLE          hFile,
        ; _IN_          LPCVOID         lpBuffer,
        ; _IN_          DWORD           nNumberOfBytesToWrite,
        ; _OUT_OPT_     LPDWORD         lpNumberOfBytesWritten,
        ; _IN_OUT_OPT_  LPOVERLAPPED    lpOverlapped
    ; );
    push    0
    lea     eax, [ebp-4]
    push    eax
    push    (message_end - message)
    push    message
    push    ebx
    call    _WriteFile@20

    ; ExitProcess( 0 )
    push    0
    call    _ExitProcess@4

    hlt
message:
    db      "Hello, world", 0xA
message_end: