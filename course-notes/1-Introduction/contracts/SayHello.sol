pragma solidity ^0.4.19;


contract SayHello {

    /* Define variable greeting of the type bytes32 */
    string greeting;

    /* This runs when the contract is executed */
    function SayHello(string _greeting)
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
        return strConcat("Hello ", greeting);
    }

    function strConcat(string _a, string _b)
        internal
        pure
        returns (string)
    {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ab = new string(_ba.length + _bb.length);
        bytes memory bab = bytes(ab);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) {
            bab[k++] = _ba[i];
        }
        for (i = 0; i < _bb.length; i++) {
            bab[k++] = _bb[i];
        }
        return string(bab);
    }
}
