// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "./standards/IERC20.sol";
import "./standards/Context.sol";
import "./standards/SafeMath.sol";
import "./standards/Address.sol";
import "./standards/ERC20.sol";
import "./standards/Ownable.sol";

contract EverestStandardOracle is Ownable {
    uint256 public _Consensus;
    
    event ValueChanged(uint256 Consensus);

    function ProvideData(uint256 Consensus) public onlyOwner {
        if (Consensus == 0 || Consensus == 1) {
            _Consensus = Consensus;
            emit ValueChanged(Consensus);   
        }
    }
    
    function retrieve() public view returns (uint256) {
        return _Consensus;
    }
}
