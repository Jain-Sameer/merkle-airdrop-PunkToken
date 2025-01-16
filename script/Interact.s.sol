// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {Script} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";

contract ClaimAirdrop is Script {
    error __ClaimDropScript_InvalidSignature(uint256 signaturelength);

    address CLAIMING_ADDRESS =0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    uint256 CLAIM_AMOUNT = 25 * 1e18;
    bytes32 proof1 = 0xd1445c931158119b00449ffcac3c947d028c0c359c34a6646d95962b3b55c6ad;
    bytes32 proof2 = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] proof = [proof1, proof2];
    bytes private SIGNATURE = hex"b567d2c267edf0681b9c4b0b613dfc1e42ae9f76974fcdd76078ff29ea5b9ee0056d71820960a5ebfbd6b7dec10bcdfcc493d618c5625e38dac0a09672fa6d3f1c";
    function claimAirdrop (address airdrop) public {
        vm.startBroadcast();
        (uint8 v, bytes32 r, bytes32 s) = splitSignature("SIGNATURE");
        MerkleAirdrop(airdrop).claim(CLAIMING_ADDRESS, CLAIM_AMOUNT, proof, v, r, s) ;
        vm.stopBroadcast();
    }
    function splitSignature(bytes memory signature) public pure returns (uint8 v, bytes32 r, bytes32 s) {
        if (signature.length != 65) {
            revert __ClaimDropScript_InvalidSignature(signature.length);
        }
        assembly {
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }
    }
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(("MerkleAirdrop"), block.chainid);
        claimAirdrop(mostRecentlyDeployed);
    }


}
// sjain@MoxWorkspace MINGW64 /c/Solidity/merkle-airdrop (main)
// $ cast call 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "getMessage(address,uint256)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 25000000000000000000 --rpc-url http://localhost:8545
// 0x184e30c4b19f5e304a89352421dc50346dad61c461e79155b910e73fd856dc72

// sjain@MoxWorkspace MINGW64 /c/Solidity/merkle-airdrop (main)
// $ cast wallet sign --no-hash 0x184e30c4b19f5e304a89352421dc50346dad61c461e79155b910e73fd856dc72 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
// 0xfbd2270e6f23fb5fe9248480c0f4be8a4e9bd77c3ad0b1333cc60b5debc511602a2a06c24085d8d7c038bad84edc53664c8ce0346caeaa3570afec0e61144dc11c

// sjain@MoxWorkspace MINGW64 /c/Solidity/merkle-airdrop (main)
// signature final : fbd2270e6f23fb5fe9248480c0f4be8a4e9bd77c3ad0b1333cc60b5debc511602a2a06c24085d8d7c038bad84edc53664c8ce0346caeaa3570afec0e61144dc11c
// 0xb567d2c267edf0681b9c4b0b613dfc1e42ae9f76974fcdd76078ff29ea5b9ee0056d71820960a5ebfbd6b7dec10bcdfcc493d618c5625e38dac0a09672fa6d3f1c