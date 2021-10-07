// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "./standards/IERC20.sol";
import "./standards/Context.sol";
import "./standards/SafeMath.sol";
import "./standards/Address.sol";
import "./standards/ERC20.sol";
import "./standards/Ownable.sol";

contract Everest_Oracle is Ownable {
    using SafeMath for uint256;
    IERC20 public pool;
    IERC20 public base;
    IERC20 public quote;
    uint256 public InitialPrice;
    uint256 public FinalPrice;
    
    function CurrentPrice() public view returns (uint256) {
        uint256 TotalBase = base.balanceOf(address(pool));
        uint256 TotalQuote = quote.balanceOf(address(pool));
        uint256 AdjustedQuote = TotalQuote.mul(10**18);
        uint256 Base_Price = AdjustedQuote.div(TotalBase);
        return Base_Price;
    }
    
    function setInitial() public onlyOwner {
        uint256 TotalBase = base.balanceOf(address(pool));
        uint256 TotalQuote = quote.balanceOf(address(pool));
        uint256 AdjustedQuote = TotalQuote.mul(10**18);
        uint256 _InitialPrice = AdjustedQuote.div(TotalBase);
        InitialPrice = _InitialPrice;
    }
    
    function setFinal() public onlyOwner {
        uint256 TotalBase = base.balanceOf(address(pool));
        uint256 TotalQuote = quote.balanceOf(address(pool));
        uint256 AdjustedQuote = TotalQuote.mul(10**18);
        uint256 _FinalPrice = AdjustedQuote.div(TotalBase);
        FinalPrice = _FinalPrice;
    }
}
