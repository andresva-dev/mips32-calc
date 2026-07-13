.data
# variables para valores de las operaciones
x:		.space 4
y:		.space 4
z: 		.space 4
# variable para la seleccion del menu
io1:		.space 4
# menus para e/s por terminal
menu1: 		.ascii "Calculadora básica en MARS \n"
		.ascii "Las opciones disponibles son: \n"
		.ascii "1. suma \n"
 		.ascii "2. resta \n"
		.ascii "3. multiplicacion \n"
 		.asciiz "4. division \n"
eleccion1:	.asciiz "Introduzca su elección:  "
val1:		.asciiz "Valor de A: "
val2:		.asciiz "Valor de B: "
resultado:	.asciiz "Resultado: "
error: 		.asciiz "No se puede dividir por 0!!! \n"

#codigo principal	
.text
MENU:
#carga de las entradas a comparar con el usuario
li 	$t0, 1
li	$t1, 2
li 	$t2, 3
li 	$t3, 4
#carga de los menus y e/s del usuario
li 	$v0, 4
la	$a0, menu1
syscall
li 	$v0, 4
la	$a0, eleccion1
syscall
li	$v0, 5
syscall
sw 	$v0, io1

#comparacion de e/s con valores inicializados para elegir la operacion correspondiente
lw	$s0, io1
beq	$s0, $t0, SUMA
beq	$s0, $t1, RESTA
beq	$s0, $t2, MULTIPLICACION
beq	$s0, $t3, DIVISION

SUMA:
#primer valor
li	$v0, 4
la	$a0, val1
syscall
li	$v0, 5
syscall
sw	$v0, x
#segundo valor
li	$v0, 4
la	$a0, val2
syscall
li 	$v0, 5
syscall
sw	$v0, y
#calculo de la operacion suma
lw	$s1, x
lw	$s2, y
add	$s3, $s1, $s2
sw	$s3, z
#muestra del resultado
li	$v0, 4
la	$a0, resultado
syscall
li	$v0, 1
lw	$a0, z
syscall
j	ENDPROG


RESTA:
#primer valor
li	$v0, 4
la	$a0, val1
syscall
li	$v0, 5
syscall
sw	$v0, x
#segundo valor
li	$v0, 4
la	$a0, val2
syscall
li 	$v0, 5
syscall
sw	$v0, y
#calculo de la operacion resta
lw	$s1, x
lw	$s2, y
sub 	$s3, $s1, $s2
sw	$s3, z
#muestra del resultado
li 	$v0, 4
la	$a0, resultado
syscall
li	$v0, 1
lw	$a0, z
j	ENDPROG


MULTIPLICACION:
#primer valor
li	$v0, 4
la	$a0, val1
syscall
li	$v0, 5
syscall
sw	$v0, x
#segundo valor
li	$v0, 4
la	$a0, val2
syscall
li 	$v0, 5
syscall
sw	$v0, y
#calculo de la operacion multiplicacion
lw	$s1, x
lw	$s2, y
mul 	$s3, $s1, $s2
sw	$s3, z
#muestra del resultado
li	$v0, 4
la	$a0, resultado
syscall
li	$v0, 1
lw	$a0, z
syscall
j	ENDPROG


DIVISION:
#primer valor
li	$v0, 4
la	$a0, val1
syscall
li	$v0, 5
syscall
sw	$v0, x
#segundo valor
li	$v0, 4
la	$a0, val2
syscall
li 	$v0, 5
syscall
sw	$v0, y
#calculo de la operacion division
lw	$s1, x
lw	$s2, y
beqz 	$s2, ERR_ZERO
div 	$s3, $s1, $s2
sw	$s3, z
#muestra del resultado
li	$v0, 4
la	$a0, resultado
syscall
li	$v0, 1
lw	$a0, z
syscall
j	ENDPROG

#manejo de 0 en el divisor en operacion division
ERR_ZERO:
li	$v0, 4
la	$a0, error
syscall
j 	MENU

#finalizacion del programa
ENDPROG:
li $v0, 17
li $a0,0
syscall 