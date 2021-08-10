// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "./standards/IERC20.sol";
import "./standards/Context.sol";
import "./standards/SafeMath.sol";
import "./standards/Address.sol";
import "./standards/ERC20.sol";
import "./standards/Ownable.sol";

contract Against is Ownable {
    address public _Opposite;
    event ValueChanged(address Opposite);
    function store(address Opposite) public onlyOwner {
        _Opposite = Opposite;
        emit ValueChanged(Opposite);
    }
}
