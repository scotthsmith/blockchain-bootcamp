pragma solidity ^0.4.19;


contract HelloWorldBytes {

    bytes32 private JACK_BYTES = 0x4a61636b00000000000000000000000000000000000000000000000000000000;

    /* Define variable greeting of the type bytes32 */
    bytes32 greeting;
    mapping (address => bytes32) whoChanged;

    modifier onlyJack(string who) {
        require(stringToBytes32(who) == JACK_BYTES);
        _;
    }

    event GreetingChanged(bytes32 itWas, bytes32 itNowIs, address changedBy);

    /* This runs when the contract is executed */
    function HelloWorldBytes(string _greeting)
        public
        onlyJack(_greeting)
    {
        greeting = stringToBytes32(_greeting);
    }

    function ()
        payable
    {
        require(msg.value != 0);
    }

    /* Main function */
    function sayHello()
        external
        view
        returns (bytes32)
    {
        return greeting;
    }

    function changeGreeting(string whoTo)
        public
    {
        bytes32 itWas = greeting;
        greeting = stringToBytes32(whoTo);
        whoChanged[msg.sender] = greeting;
        emit GreetingChanged(itWas, greeting, msg.sender);
    }

    function changedWhat(address who)
        public
        view
        returns(bytes32)
    {
        return whoChanged[who];
    }

    function stringToBytes32(string memory source)
        internal
        pure
        returns (bytes32 result)
    {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }
}
