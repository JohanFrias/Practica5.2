Feature: Transferencia de dinero entre cuentas
  Como cliente del banco
  Quiero transferir dinero a otra cuenta
  Para pagar o enviar fondos de forma rapida y segura

  Background:
    Given que el usuario "Johan Frias" ha iniciado sesion
    And tiene una cuenta de ahorros con saldo de RD$ 50,000

  # ESCENARIO 1 - Caso exitoso
  Scenario: Transferencia exitosa a una cuenta existente
    Given que existe la cuenta destino "100621819" a nombre de "Esbenni Morel"
    When el usuario transfiere RD$ 10,000 a la cuenta "100621819"
    And confirma la operacion con su codigo de seguridad correcto
    Then el sistema muestra el mensaje "Transferencia realizada con exito"
    And el saldo de Johan Frias queda en RD$ 40,000
    And se genera un comprobante con numero de referencia

  # ESCENARIO 2 - Caso exitoso (valor limite)
  Scenario: Transferencia por el saldo total disponible
    Given que existe la cuenta destino "100621819" a nombre de "Esbenni Morel"
    When el usuario transfiere RD$ 50,000 a la cuenta "100621819"
    And confirma la operacion con su codigo de seguridad correcto
    Then el sistema procesa la transferencia
    And el saldo de Johan Frias queda en RD$ 0

  # ESCENARIO 3 - Error: fondos insuficientes
  Scenario: Transferencia rechazada por saldo insuficiente
    Given que existe la cuenta destino "100621819" a nombre de "Esbenni Morel"
    When el usuario intenta transferir RD$ 60,000 a la cuenta "100621819"
    Then el sistema muestra el mensaje "Fondos insuficientes"
    And el saldo de Johan Frias permanece en RD$ 50,000
    And no se genera ningún comprobante

  # ESCENARIO 4 - Error: cuenta destino inexistente
  Scenario: Transferencia rechazada por cuenta destino inexistente
    Given que la cuenta "999999999" no existe en el sistema
    When el usuario intenta transferir RD$ 5,000 a la cuenta "999999999"
    Then el sistema muestra el mensaje "La cuenta destino no existe"
    And no se descuenta dinero de la cuenta de Johan Frias

  # ESCENARIO 5 - Error: monto inválido (Scenario Outline)
  Scenario Outline: Transferencia rechazada por monto inválido
    Given que existe la cuenta destino "100621819" a nombre de "Esbenni Morel"
    When el usuario intenta transferir "<monto>" a la cuenta "100621819"
    Then el sistema muestra el mensaje "<mensaje>"
    And el saldo de Johan Frias permanece en RD$ 50,000

    Examples:
      | monto | mensaje                          |
      | 0     | El monto debe ser mayor a cero   |
      | -500  | El monto debe ser mayor a cero   |
      | abc   | Ingrese un monto numerico valido |

  # ESCENARIO 6 - Error: codigo de seguridad incorrecto
  Scenario: Transferencia cancelada por codigo de seguridad incorrecto
    Given que existe la cuenta destino "100621819" a nombre de "Esbenni Morel"
    When el usuario transfiere RD$ 10,000 a la cuenta "100621819"
    And ingresa un codigo de seguridad incorrecto
    Then el sistema muestra el mensaje "Código de seguridad inválido"
    And la transferencia no se ejecuta
    And el saldo de Johan Frias permanece en RD$ 50,000

  # ESCENARIO 7 - Error: limite diario excedido
  Scenario: Transferencia rechazada por exceder el limite diario
    Given que el usuario ya transfirio RD$ 95,000 el día de hoy
    And existe la cuenta destino "100621819" a nombre de "Esbenni Morel"
    When el usuario intenta transferir RD$ 10,000 a la cuenta "100621819"
    Then el sistema muestra el mensaje "Ha excedido su limite diario de transferencias"
    And la transferencia no se ejecuta
