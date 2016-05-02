# RomeCLI
### A CLI tool for [Rome Server](https://github.com/146BC/Rome) written in Swift

### Usage examples

## Clients

- List Clients
    - romecli -o list-clients
- Add Client
    - romecli -o add-client -p ClientName
- Delete Client
    - romecli -o delete-client -p 5724c65da9e0520f5aa25984

## Assets

- List Assets
    - romecli -o list-assets
- Get Asset
    - romecli -o get-asset -p AssetName 1.0
- Get Asset By Id
    - romecli -o get-asset -p 5724c65da9e0520f5aa25984
- Add Asset
    - romecli -o add-asset -p AssetName 1.0 /Users/alex/asset.zip
- Delete Asset
    - romecli -o delete-asset -p 5724c65da9e0520f5aa25984
- Update Asset
    - romecli -o update-asset -p 5724c65da9e0520f5aa25984 true