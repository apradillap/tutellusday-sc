require('dotenv').config()
require("@nomiclabs/hardhat-waffle");
require('@nomiclabs/hardhat-etherscan')

module.exports = {
    networks: {
      hardhat: {
        allowUnlimitedContractSize: true
      },
      goerli: {
        url: process.env.RPC_URL_GOERLI,
        gas: 'auto',
        accounts: {
          mnemonic: process.env.MNEMONIC
        }
      } 
    },
    solidity: {
      compilers: [
        { version: "0.8.9" },
      ]
    },
    etherscan: {
      apiKey: {
        goerli: process.env.ETHERSCAN_API_KEY_GOERLI
      }
    }
}
