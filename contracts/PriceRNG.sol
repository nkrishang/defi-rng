// SPDX-License-Identifier: MIT

import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol';

pragma solidity ^0.8.0;

contract PriceRNG {
  /// @dev returns sorted token addresses, used to handle return values from pairs sorted in this order
  /// @notice See `UniswapV2Library.sol`
  function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
    require(tokenA != tokenB, 'UniswapV2Library: IDENTICAL_ADDRESSES');
    (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
    require(token0 != address(0), 'UniswapV2Library: ZERO_ADDRESS');
  }

  /// @dev fetches and sorts the reserves for a pair
  /// @notice See `UniswapV2Library.sol`
  function getReserves(address pair, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
    (address token0,) = sortTokens(tokenA, tokenB);
    (uint reserve0, uint reserve1,) = IUniswapV2Pair(pair).getReserves();
    (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
  }
}