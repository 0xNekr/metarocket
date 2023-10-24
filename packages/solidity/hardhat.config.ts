import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: '0.8.20',
        settings: {optimizer: {enabled: true}}
      }
    ],
  },
  networks: {
    polygonMumbai: {
      url: process.env.POLYGON_MUMBAI_RPC_URL!,
      accounts: [process.env.TESTNET_PRIVATE_KEY!],
      chainId: 80001
    },
    polygonMainnet: {
      url: process.env.POLYGON_MAINNET_RPC_URL!,
      accounts: [process.env.MAINNET_PRIVATE_KEY!],
      chainId: 137
    }
  },
  etherscan: {
    apiKey: {
      polygonMumbai: process.env.POLYGONSCAN_API_KEY!,
    }
  }, paths: {
    artifacts: "./artifacts"
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined ? process.env.REPORT_GAS == 'true' : false,
    coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    currency: 'USD',
    token: process.env.GAS_REPORTER_TOKEN,
    gasPriceApi:
        process.env.GAS_REPORTER_TOKEN == 'ETH'
            ? 'https://api.etherscan.io/api?module=proxy&action=eth_gasPrice'
            : process.env.GAS_REPORTER_TOKEN == 'MATIC'
                ? 'https://api.polygonscan.com/api?module=proxy&action=eth_gasPrice'
                : 'https://api.snowtrace.io/api?module=proxy&action=eth_gasPrice'
  },
  mocha: {
    timeout: 40000
  }
};

export default config;
