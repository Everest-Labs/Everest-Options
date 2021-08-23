// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "./standards/IERC20.sol";
import "./standards/Context.sol";
import "./standards/SafeMath.sol";
import "./standards/Address.sol";
import "./standards/ERC20.sol";
import "./standards/Ownable.sol";

contract EverestStandardOracle is Ownable {
    bool public _FinalResult;

    function Oracle_Consensus(bool FinalResult) public onlyOwner {
            _FinalResult = FinalResult;
    }
}
