import Foundation

struct HelpCommand {
    
    func printHelp() {
        print("Clients")
        print("List Clients: romecli -o list-clients")
        print("Add Client: romecli -o add-client -p ClientName")
        print("Delete Client: romecli -o delete-client -p 5724c65da9e0520f5aa25984")
        print("")
        print("Assets")
        print("List Assets: romecli -o list-assets")
        print("Get Asset: romecli -o get-asset -p AssetName 1.0")
        print("Get Asset By Id: romecli -o get-asset -p 5724c65da9e0520f5aa25984")
        print("Add Asset: romecli -o add-asset -p AssetName 1.0 /Users/alex/asset.zip")
        print("Delete Asset: romecli -o delete-asset -p 5724c65da9e0520f5aa25984")
        print("Update Asset: romecli -o update-asset -p 5724c65da9e0520f5aa25984 true")
        print("")
        print("Environment variables ROME_ENDPOINT & ROME_KEY need to be set")
        print("")
    }
    
}
