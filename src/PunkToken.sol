// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
// "lib\openzeppelin-contracts\contracts\token\ERC20\ERC20.sol"

contract PunkToken is ERC20, Ownable {
    constructor() ERC20("Punk", "PUNK") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
