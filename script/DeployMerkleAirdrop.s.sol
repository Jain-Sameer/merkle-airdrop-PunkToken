// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PunkToken} from "../src/PunkToken.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DeployAirdrop is Script {
    bytes32 private s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private s_amountToTransfer = 4 * 25 * 1e18;

    function deployMerkleAirdrop() public returns (PunkToken, MerkleAirdrop) {
        vm.startBroadcast();
        PunkToken token = new PunkToken();
        MerkleAirdrop airdrop = new MerkleAirdrop(s_merkleRoot, token);
        token.mint(token.owner(), s_amountToTransfer);
        token.transfer(address(airdrop), s_amountToTransfer);
        vm.stopBroadcast();
        return (token, airdrop);
    }

    function run() external returns (PunkToken, MerkleAirdrop) {
        return deployMerkleAirdrop();
    }
}
