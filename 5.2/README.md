1.	Transferencia exitosa (Exito): El flujo principal, descuento correcto del saldo, mensaje de confirmacion y generacion del comprobante.

2.	Transferencia por el saldo total (Exito) Que el sistema permita transferir exactamente todo el saldo disponible y no falle en el limite inferior (saldo queda en 0).

3.	Saldo insuficiente (Error): Que no se pueda transferir más de lo disponible y que el saldo no se altere.

4.	Cuenta destino inexistente (Error): La validación de la cuenta destino antes de mover dinero, evitando envíos a cuentas inválidas.

5.	Monto invalido (Error): Las validaciones de entrada: cero, negativos y texto no numerico, probadas con varios datos en un solo escenario.

6.	Codigo de seguridad incorrecto (Error): La seguridad de la operación, sin autorización válida, la transferencia no se ejecuta.

7.	Límite diario excedido(Error): La regla de negocio de limite diario, que protege al cliente y al banco.
