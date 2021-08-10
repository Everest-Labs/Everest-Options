// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "./standards/IERC20.sol";
import "./standards/Context.sol";
import "./standards/SafeMath.sol";
import "./standards/Address.sol";
import "./standards/ERC20.sol";
import "./standards/Ownable.sol";

contract EverestStandardOracle is Ownable {
    uint256 public _Expired;
    event ValueChanged(uint256 Expired);
    function store(uint256 Expired) public onlyOwner {
        _Expired = Expired;
        emit ValueChanged(Expired);
    }
    function retrieve() public view returns (uint256) {
        return _Expired;
    }
}
