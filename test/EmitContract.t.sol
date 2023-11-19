pragma solidity 0.8.10;

import "forge-std/Test.sol";
import {ExpectEmit} from "../src/ExpectEmit.sol";

contract EmitContractTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function test_ExpectEmit() public {
        ExpectEmit emitter = new ExpectEmit();

        // Comprueba que el topic 1, topic 2, y la data sean los mismos que los del siguiente evento emitido
        // Verificar el topic 3 aqui no importa porque `Transfer` solo tiene 2 topics indexados
        vm.expectEmit(true, true, false, true);
        // El evento que esperamos
        emit Transfer(address(this), address(1337), 1337);
        // El evento que obtenemos
        emitter.t();
    }

    function test_ExpectEmit_DoNotCheckData() public {
        ExpectEmit emitter = new ExpectEmit();

        // Verifica el topic 1 y topic 2, pero no chequea la data
        vm.expectEmit(true, true, false, false);
        // El evento que esperamos
        emit Transfer(address(this), address(1337), 1338);
        // El evento que obtenemos
        emitter.t();
    }
}
