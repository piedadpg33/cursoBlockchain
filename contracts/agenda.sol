// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;
//struct y array
    //mapping de mapping
    //2 contratos

contract Agenda {
    
    
    mapping(address =>mapping(address=>string) ) private agenda;
    mapping(address => mapping(address => uint256)) private delegados;
    
    modifier acceso(address _owner) {
        require(
            msg.sender == _owner || delegados[_owner][msg.sender] > block.timestamp,
            "No read access"
        );
        _;
    }

    function delegarAccesoLectura(address delegado, uint256 tiempoExpiracion) public {
        delegados[msg.sender][delegado] = block.timestamp + tiempoExpiracion;
    }
    
    function agregar (address direccion, string memory nombre ) public  {
        agenda[msg.sender][direccion]=nombre;

    }

    function editar (address direccion, string memory nombre ) public {
        require(bytes(agenda[msg.sender][direccion]).length != 0, "Contact does not exist");
        agenda[msg.sender][direccion]=nombre;
        
    }

    function borrar (address direccion ) public {
        require(bytes(agenda[msg.sender][direccion]).length != 0, "Contact does not exist");
        delete agenda[msg.sender][direccion];
        
    }
    
    function getNombre(address direccion) public view acceso(msg.sender) returns (string memory nombre)   {
        return agenda[msg.sender][direccion];
    }

    function getDireccion(string memory name) public view acceso(msg.sender) returns (string memory nombre)  {
        
    }



    }