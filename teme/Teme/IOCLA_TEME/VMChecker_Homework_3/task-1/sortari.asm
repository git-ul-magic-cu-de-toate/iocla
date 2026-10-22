section .text
global sort
; NODE_SIZE = 8 (the size of a node) (has a tab because of linter........)
    %define NODE_SIZE 8
;   struct node {
;    int val;
;    struct node* next;
;   };

;; struct node* sort(int n, struct node* node);
;   The function will link the nodes in the array
;   in ascending order and will return the address
;   of the new found head of the list
; @params:
;   n -> the number of nodes in the array
;   node -> a pointer to the beginning in the array
;   @returns:
;   the address of the head of the sorted list
sort:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push esi
    push edi

    ; ebx - pointer to node array
    mov ebx, [ebp + 12]

    ; edi = head (final return value)
    ; esi = curr pointer (starts as NULL)
    xor edi, edi
    xor esi, esi

    ; search the node with value 1
    ; ecx = i
    xor ecx, ecx
find_head_loop_start:
    ; check i < n
    cmp ecx, [ebp + 8]
    je find_head_loop_start
    inc ecx

    ; eax = node[i].val
    mov eax, [ebx + (ecx - 1) * NODE_SIZE]

    ; check if head is found
    cmp eax, 1
    jne find_head_loop_start

    ; eax = &node[i]
    ; edi = head
    ; esi = current = head
    lea eax, [ebx + (ecx - 1) * NODE_SIZE]
    mov edi, eax
    mov esi, eax

find_head_loop_end:
    ; Link nodes in order: 1 -> 2 -> 3 -> ... -> n
    ; val = 2
    mov ecx, 2

val_loop_start:
    ; if val > n, stop
    cmp ecx, [ebp + 8]
    jg end

    ; j = 0
    xor edx, edx
find_next:
    ; eax = node[j].val
    mov eax, [ebx + edx * NODE_SIZE]

    cmp eax, ecx
    jne next_j

    ; node with val ecx is found
    ; eax = &node[j]
    lea eax, [ebx + edx * NODE_SIZE]
    ; current->next = &node[j]
    mov [esi + 4], eax
    ; current = current->next
    mov esi, eax
    jmp next_val

next_j:
    inc edx
    ; if j > n, stop
    cmp edx, [ebp + 8]
    jl find_next

next_val:
    inc ecx
    jmp val_loop_start

end:
    ; current->next = NULL
    mov dword [esi + 4], 0

    ; return head
    mov eax, edi

    pop edi
    pop esi
    pop ebx
    leave
    ret
