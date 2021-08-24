//SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./standards/IERC20.sol";
import "./standards/Context.sol";
import "./standards/SafeMath.sol";
import "./standards/Address.sol";
import "./standards/ERC20.sol";
import "./standards/Ownable.sol";

contract ChainlinkIntegration is Ownable {
    AggregatorV3Interface internal priceFeed;
    int public latestprice;
    
    /**
     * Network: Fuji
     * Aggregator: AVAX/USD
     * Address: 0x5498BB86BC934c8D34FDA08E81D444153d0D06aD
     */
    constructor() public {
        priceFeed = AggregatorV3Interface(0x5498BB86BC934c8D34FDA08E81D444153d0D06aD);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return price;
    }
}

