pragma solidity 0.8.10;

error Unauthorized();

contract OwnerUpOnly {
    address public immutable owner;
    uint256 public count;
    // Nuevo evento
    event Caller(address indexed sender);

    constructor() {
        owner = msg.sender;
    }

    function increment() external {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        count++;
    }

    // Nueva funcion
    function incrementNotOwner() external {
        count++;
        emit Caller(msg.sender);
    }
}
