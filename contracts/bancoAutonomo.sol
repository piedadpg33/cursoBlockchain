// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//smart contract similar a un banco donde dejo deposito
//no retirar mas del que se mete
//pedir dinero al banco si el banco tiene money

contract Banco {
    //para hacer for hay que guardar direcciones
    //el smart contract se hace referencia a el mismo address(this).balance
    mapping(address => uint256) private saldos;
    mapping(address => uint256) private deudores;


    //para recibir public payable msg.value
    //para enviar payable(msg.sender).transfer(monto)
    //funcion fallback cuando pones ether y no especificas la funcion (primeros 4 bytes en calldata)
    //transfer -> programada sin guardas que impiden ataques
    //execution cost  gas de la funcion
    //transaction para evitar ataques OS 20000 gas
    //patron CHECKS EFFECTS INTERACT
    //primero cambio estado y luego interaccion

    function depositar() external payable { 
    //public la puedo llamar desde el mismo contrato
    //external no, pero banco no va a depositar saldo  en el mismo
    // msg.value siempre es uint256 poner por si acaso
        require(msg.value > 0, "El deposito debe ser mayor a 0");
        saldos[msg.sender] += msg.value;
    }

    function retirar(uint256 monto) public {
        require(saldos[msg.sender] >= monto, "Saldo insuficiente");
        require( address(this).balance>= monto, "No disponemos de tantos fondos en este momento, siga esperando");
        saldos[msg.sender] -= monto;
        payable(msg.sender).transfer(monto);
    }

    function consultar() public view returns (uint256) {
        return saldos[msg.sender];
    }
    
    function pedirPrestamo(uint256 _monto) public {
        require(_monto > 0, "El deposito debe ser mayor a 0");
        require(deudores[msg.sender]>0, "ya se le hizo un prestamo y aun no ha sido devuelto");
        require(_monto<=address(this).balance, "no se dispone de dicha cantidad en nuestros fondos en estos momentos");
        
        deudores[msg.sender] = _monto;
        saldos[msg.sender] += _monto;
        //payable(msg.sender).transfer(_monto); MAL, EVITAR PAGAR
    }

    function pagarPrestamo() external payable {
        require(msg.value<= deudores[msg.sender], "el valor enviado es mayor que la deuda a pagar");
        deudores[msg.sender] -= msg.value;
        if(deudores[msg.sender]==0){
            delete deudores[msg.sender];
        }
    }
    function pagarPrestamoConSaldo(uint256 cantidad) public {
        require(cantidad<= deudores[msg.sender], "el valor enviado es mayor que la deuda a pagar");
        deudores[msg.sender] -= cantidad;
        if(deudores[msg.sender]==0){
            delete deudores[msg.sender];
        }
    }

    function consultarSaldoDeudor(address _cuenta) public view returns (uint256) {
        return deudores[_cuenta];
        
    }




}