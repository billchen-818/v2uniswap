// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {Math} from "./libraries/Math.sol";

contract UniswapV2Pair is ERC20, Math {
    // 定义常量 最小的流动性
    uint256 constant MINIMUM_LIQUIDITY = 1000;

    // 池子中交易对的地址
    address public token0;
    address public token1;

    // 池子中的储备量
    uint256 private reserve0;
    uint256 private reserve1;

    constructor(address _token0, address _token1) ERC20("ZuniswapV2 Pair", "ZUNIV2", 18) {
        token0 = _token0;
        token1 = _token1;
    }
}
