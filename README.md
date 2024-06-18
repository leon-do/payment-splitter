# Payment Spliter Vault Token

Modification of [https://docs.openzeppelin.com/contracts/2.x/api/payment](https://docs.openzeppelin.com/contracts/4.x/api/finance#PaymentSplitter)

This contract allows to split Ether payments among a group of accounts. The sender does not need to be aware that the Ether will be split in this way, since it is handled transparently by the contract.

The split can be in equal parts or in any other arbitrary proportion. The way this is specified is by determining the number of vaultTokens (ERC20). Of all the Ether that this contract receives, each account will then be able to claim an amount proportional to the percentage of vaultTokens they own. The distribution of shares is dynamic based on the vaultToken balance.

PaymentSplitter follows a pull payment model. This means that payments are not automatically forwarded to the accounts but kept in this contract, and the actual transfer is triggered as a separate step by calling the release function.

![Screenshot 2024-06-17 at 10 45 26 PM](https://github.com/leon-do/payment-spliter/assets/19412160/bb574b6b-a386-4bed-8b45-4bc79970e49a)
