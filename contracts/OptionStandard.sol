//SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./standards/IERC20.sol";
import "./standards/Context.sol";
import "./standards/SafeMath.sol";
import "./standards/Address.sol";
import "./standards/ERC20.sol";
import "./standards/Ownable.sol";
import "./EverestStandardOracle.sol";

contract OptionsStandard is ERC20("TokenOPT0831", "TOKENOPT0831"), EverestStandardOracle {
    using SafeMath for uint256;
    IERC20 public token;
    string public ticker;
    address public Opposite;
    address public BurnAddress;
    uint256 public constant AdjustedPeriod = 7 days;
    uint256 public constant ContractPeriod = 30 days;
    
    event AddressChanged(address Opposite);
    
    constructor(IERC20 _token, string memory _ticker) public {
        token = _token;
        ticker = _ticker;
        BurnAddress = 0x0000000000000000000000000000000000000000;
    }

    function deposit(uint256 _amount) public {
        if (block.timestamp <= block.timestamp.add(AdjustedPeriod)) {
            _mint(msg.sender, _amount);
            token.transferFrom(msg.sender, address(this), _amount);
        }
    }
    
    function ContraryContract(address _Opposite) public onlyOwner {
        if (Opposite == BurnAddress) {
            Opposite = _Opposite;
            emit AddressChanged(_Opposite);
        }
    }
    
    function lost() public onlyOwner {
        uint256 OwnerFee = token.balanceOf(address(this)).div(40);
        uint256 totalToken = token.balanceOf(address(this)).sub(OwnerFee);
        if (_Consensus == 1) {
            token.transfer(msg.sender, OwnerFee);
            token.transfer(Opposite, totalToken);
        }
    }
    
    function claim(uint256 _amount) public {
        uint256 totalAmount = totalSupply();
        uint256 fair = _amount.mul(token.balanceOf(address(this))).div(totalAmount);
        if (block.timestamp >= block.timestamp.add(ContractPeriod)) {
            _burn(msg.sender, _amount);
            token.transfer(msg.sender, fair);
        }
    }
    
    function TickerExpiry() public view returns (string memory) {
        return asset;
    }
}
