
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// EJERCICIO 1
contract SimpleStorage11 {
    uint storedData=1;

    function set(uint x) public {
        storedData = combine(storedData, x);
    }

    function get() public view returns (uint) {
        return storedData;
    }

    function combine(uint a, uint b) public pure returns (uint) {
        return a * b;
    }
    
}

//CONTRATO QUE UTILIZA EL ANTERIOR pasar la direccion del contrato al ataddress
contract SimpleStorageAlmacen {
    SimpleStorage11 almacen;

    function set(uint x) public {
        almacen.set(x);
    }

    function get() public view returns (uint) {
        return almacen.get();
    }

    function combine(uint a, uint b) public pure returns (uint) {
        return a * b;
    }
    
}
contract SimpleStorage12 {
    uint storedData=1;

    function set(uint x) public {
        storedData = combine(x);
    }

    function get() public view returns (uint) {
        return storedData;
    }

    function combine(uint x) public view returns(uint) {
        return x * storedData;
    }
    
}


/*
    EJERCICIO 2

    El coste de almacenar el valor modificado es un gas de 30919 gas, el coste de transacción es 26886 gas y el de ejecución es 5682 gas
    El coste de  consultar equivale al coste de ejecución, 2432 gas.

*/

/* EJERCICIO 3
    Un error que ocurría es que Storedata se inicializaba a 0, así que el resultado de la multiplicación era cero
    Al realizar la multiplicación puede ocurrir un desbordamiento, es decir, que el resultado sea un número mayor 
    que el máximo permitido por uint (2^256 - 1), para evitarlo podemos usar la biblioteca de OpenZeppelin, SafeMath.

    Después de leer la librería, la conclusión es que para la división por cero también podemos usar SafeMath, exactamente la 
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) que hace uso de require para este caso
    y se pasa un mensaje personalizado.


*/
contract SimpleStorage31 {
    uint storedData=1;

    function set(uint x) public {
        storedData = combine(storedData, x);
    }

    function get() public view returns (uint) {
        return storedData;
    }

    function combine(uint a, uint b) public pure returns (uint) {
        return SafeMath.mul(a,b);
    }
}

contract SimpleStorage32 {
    uint storedData=30;

    function set(uint x) public {
        storedData = combine(storedData, x);
    }

    function get() public view returns (uint) {
        return storedData;
    }

    function combine(uint a, uint b) public pure returns (uint) {
        return SafeMath.div(a,b,"ingrese un uint diferente a cero :)");
    }
}


/* EJERCICIO 4
    El coste de  consultar siendo uint8 ha sido más caro, 2473 gas, así que el tamaño influye
    El coste  de consultar al utilizar uint es 2410 gas, ha sido más barato.
*/
contract SimpleStorage41 {
    uint8 storedData=1;

    function set(uint8 x) public {
        storedData = combine(storedData, x);
    }

    function get() public view returns (uint8) {
        return storedData;
    }

    function combine(uint8 a, uint8 b) public pure returns (uint8) {
        return a*b;
    }
}

contract SimpleStorage42 {
     int storedData=1;

    function set(int x) public {
        storedData = combine(storedData, x);
    }

    function get() public view returns (int) {
        return storedData;
    }

    function combine(int a, int b) public pure returns (int) {
        return a*b;
    }
}

// EJERCICIO 5 
    
contract SimpleStorage5 {
    uint storedData=1;
    address  owner;

    function set(uint x) public {
        
        owner= msg.sender;
        owner= tx.origin;
        storedData = combine(storedData, x);
    }

    function get() public view returns (uint) {
        if(msg.sender!=owner){
            return 0;
        }else{
            return storedData;
        }
    }

    function combine(uint a, uint b) public pure returns (uint) {
        return SafeMath.mul(a,b);
    }
}

// EJERCICIO 6
contract SimpleStorage6 {
    uint storedData;
    address public owner;

    constructor() {
        storedData=1;
    }

    function set(uint x) public {
        storedData = combine(storedData, x);
        owner= msg.sender;
    }

    function get() public view returns (uint) {
        if(msg.sender!=owner){
            return 0;
        }else{
            return storedData;
        }
    }

    function combine(uint a, uint b) public pure returns (uint) {
        return SafeMath.mul(a,b);
    }
}




// EJERCICIO 7
contract SimpleStorage7 {
    uint storedData;
    address public owner;

    constructor() {
        storedData=1;
        owner= msg.sender;
    }

    function set(uint x) public {
        storedData = combine(storedData, x);
        require(
            msg.sender == owner,
            "Only owner can call this :P"
        );
    }

    function get() public view returns (uint) {
        return storedData;
    }

    function combine(uint a, uint b) public pure returns (uint) {
        return SafeMath.mul(a,b);
    }
}

