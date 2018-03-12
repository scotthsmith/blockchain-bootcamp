pragma solidity ^0.4.19;


contract HelloWorld {

    /* Define variable greeting of the type bytes32 */
    string greeting;

    /* This runs when the contract is executed */
    function HelloWorld(string _greeting)
        public
    {
        greeting = _greeting;
    }

    /* Main function */
    function sayHello()
        external
        view
        returns (string)
    {
        return greeting;
    }
}
