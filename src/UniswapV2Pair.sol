// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {Math} from "./libraries/Math.sol";

interface IERC20 {
    function balanceOf(address) external returns (uint256);
}

error InsufficientLiquidityMinted();

contract UniswapV2Pair is ERC20, Math {
    // 定义常量 最小的流动性
    uint256 constant MINIMUM_LIQUIDITY = 1000;

    // 池子中交易对的地址
    address public token0;
    address public token1;

    // 池子中的储备量
    uint256 private reserve0;
    uint256 private reserve1;

    event Mint(address, uint256, uint256);
    event Sync(uint256, uint256);

    constructor(address _token0, address _token1) ERC20("ZuniswapV2 Pair", "ZUNIV2", 18) {
        token0 = _token0;
        token1 = _token1;
    }

    function mint() public {
        uint256 balance0 = IERC20(token0).balanceOf(address(this));
        uint256 balance1 = IERC20(token1).balanceOf(address(this));
        uint256 amount0 = balance0 - reserve0;
        uint256 amount1 = balance1 - reserve1;
        uint256 liquidity;

        if (totalSupply == 0) {
            liquidity = Math.sqrt(amount0 * amount1) - MINIMUM_LIQUIDITY;
            _mint(address(0), MINIMUM_LIQUIDITY);
        } else {
            liquidity = Math.min(
                (amount0 * totalSupply) / reserve0,
                (amount1 * totalSupply) / reserve1
            );
        }

        if (liquidity <= 0) {
            revert InsufficientLiquidityMinted();
        }

        _mint(msg.sender, liquidity);

        _update(balance0, balance1);

        emit Mint(msg.sender, amount0, amount1);
    }

    function _update(uint256 balance0, uint256 balance1)  private {
        reserve0 = balance0;
        reserve1 = balance1;

        emit Sync(reserve0, reserve1);
    }
}
