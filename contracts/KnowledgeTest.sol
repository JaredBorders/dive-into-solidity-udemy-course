//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract KnowledgeTest {
    address public owner;
    string[] public tokens = ["BTC", "ETH"];
    address[] public players;

    modifier onlyOwner() {
        require(msg.sender == owner, "ONLY_OWNER");
        _;
    }

    error txFailed(bytes b);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function changeTokens() public {
        string[] storage t = tokens;
        t[0] = "VET";
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function transferAll(address dest) external onlyOwner {
        (bool success, bytes memory returnBytes) = dest.call{
            value: getBalance()
        }("");
        if (!success) {
            revert txFailed(returnBytes);
        }
    }

    function start() external {
        players.push(msg.sender);
    }

    function concatenate(string calldata str1, string calldata str2)
        external
        pure
        returns (string memory)
    {
        return string(abi.encodePacked(str1, str2));
    }
}
