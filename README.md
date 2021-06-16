# DEX RNG

`DexRNG.sol` is a permissionless random number generator contract. It uses the total
reserve value of Uniswap and Sushiswap pairs as a source of randomness.

The primary random number function of the contract is 
```solidity
getRandomNumber(uint range) external returns(uint randomNumber, bool acceptableEntropy)
``` 
On every `getRandomNumber` call, the contract queries the total reserve value
of the DEX pairs to use in its generation of a random number. 

The contract treats a random number as generated with "acceptable entropy" if the 
reserve value of at least one of the DEX pairs used in the generation has updated 
since the previous call to the random number function.

The EAO / contract calling `getRandomNumber` is left to handle the `acceptableEntropy`
value as it pleases.


## Run Locally

Clone the project

```bash
  git clone https://github.com/nkrishang/dex-rng.git
```

Install dependencies

```bash
  yarn install
```

  
## Running Tests

To run hardhat tests, run the following command

```bash
npx hardhat test
```
The tests in `test/` serve the following purpose:
- `contract.js` tests contract state changes.
- `gas.js` prints the estimated gas consumption of the contract functions. 
  The test prints the gas consumption of calling `getRandomNumber` with up to 6 DEX pairs.
- `healthCheck.js` prints the `randomNumber` and `acceptableEntropy` values
  for the 10 most recent mainnet blocks.

The tests use hardhat's mainnet-forking feature. You will require provider API keys
to successfully run the tests. The project uses [Alchemy](https://www.alchemy.com/)
as a provider.

  
## Deployment

To deploy this project on a given network (e.g. mainnet) update the
`hardhat.config.js` as follows:

```javascript
module.exports = {
  solidity: "0.8.0",
  networks: {
    mainnet: {
      url: `https://eth-mainnet.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      accounts: [`${TEST_PRIVATE_KEY}`]
    }
  }
};
```
After updating the config file, run

```bash
  npx hardhat run scripts/deploy.js --network mainnet
```

  
## Feedback

If you have any feedback, please reach out to us at krishang@nftlabs.co or support@nftlabs.com

  
## Contributors

- [@nkrishang](https://github.com/nkrishang)

  
## License

[MIT](https://choosealicense.com/licenses/mit/)