pragma solidity 0.8.10;

contract ExpectEmit {
    // Evento Transfer
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // Función que solo emite el evento Transfer
    function t() public {
        emit Transfer(msg.sender, address(1337), 1337);
    }
}
