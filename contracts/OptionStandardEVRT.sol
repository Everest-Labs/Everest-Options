//SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./standards/IERC20.sol";
import "./standards/Context.sol";
import "./standards/SafeMath.sol";
import "./standards/Address.sol";
import "./standards/ERC20.sol";
import "./standards/Ownable.sol";
import "./EverestOracle/EverestStandardOracle.sol";

contract EVRTCALL is ERC20("Everest Token Call 1006", "EVRT1006"), Everest_Oracle {
    using SafeMath for uint256;
    IERC20 public token;
    string private asset;
    string private expiry;
    uint256 private OracleFee;
    uint256 public InitialBlock;
    address public Opposite;
    address private BurnAddress;
    uint256 public AdjustedPeriod;
    uint256 public ContractPeriod;
    
    event AddressChanged(address Opposite);
    
    constructor(IERC20 _token, string memory _asset, string memory _expiry, uint256 _OracleFee, uint256 _Adjusted, uint256 _Contract, IERC20 _pool, IERC20 _base, IERC20 _quote) public {
        token = _token;
        asset = _asset;
        expiry = _expiry;
        OracleFee = _OracleFee;
        pool = _pool;
        base = _base;
        quote = _quote;
        AdjustedPeriod = _Adjusted;
        ContractPeriod = _Contract;
        InitialBlock = block.timestamp;
    }

    function deposit(uint256 _amount) public {
        require (block.timestamp < InitialBlock.add(AdjustedPeriod), "don't pls");
            _mint(msg.sender, _amount);
            token.transferFrom(msg.sender, address(this), _amount);
    }
    
    function ContraryContract(address _Opposite) public onlyOwner {
        require(Opposite == address(0), "no");
            Opposite = _Opposite;
            emit AddressChanged(_Opposite);
    }
    
    function lost() public onlyOwner {
        require (FinalPrice != 0 || FinalPrice < InitialPrice, "no");
        require (block.timestamp > InitialBlock.add(AdjustedPeriod.mul(2)));
        uint256 OwnerFee = token.balanceOf(address(this)).div(OracleFee);
        uint256 totalToken = token.balanceOf(address(this)).sub(OwnerFee);
            token.transfer(msg.sender, OwnerFee);
            token.transfer(Opposite, totalToken);
    }
    
    function claim(uint256 _amount) public {
        require (block.timestamp > InitialBlock.add(ContractPeriod), "no");
        uint256 totalAmount = totalSupply();
        uint256 fair = _amount.mul(token.balanceOf(address(this))).div(totalAmount);
            _burn(msg.sender, _amount);
            token.transfer(msg.sender, fair);
    }
    
    function Asset() public view returns (string memory) {
        return asset;
    }
    
    function Expiry() public view returns (string memory) {
        return expiry;
    }
}
