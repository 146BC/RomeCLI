import CommandLine
import Foundation
import RomeKit
import Alamofire

let env = NSProcessInfo.processInfo().environment

if let baseUrl = env["ROME_ENDPOINT"], apiKey = env["ROME_KEY"] {
    let bootstrap = RomeKit.Bootstrap.init(baseUrl: baseUrl, apiKey: apiKey)
    bootstrap?.start()
} else {
    print("Environment variables ROME_ENDPOINT & ROME_KEY not set")
}

func startOperation(operation: Operation?, parameters: [String]?) {
    guard let operation = operation else {
        cli.printUsage()
        exit(EX_USAGE)
    }
    
    switch operation {
    case .ListClients:
        ClientCommand().list()
    case .AddClient:
        if let parameters = parameters, clientName = parameters.first {
            print("Adding Client with name:", clientName)
            ClientCommand().add(clientName)
        } else {
            print("Error executing command, format should be: romecli -o add-client -p ClientName")
            return
        }
    case .DeleteClient:
        if let parameters = parameters, clientId = parameters.first {
            print("Deleting Client with id:", clientId)
            ClientCommand().delete(clientId)
        } else {
            print("Error executing command, format should be: romecli -o delete-client -p 5724c65da9e0520f5aa25984")
            return
        }
    case .ListAssets:
        AssetCommand().list()
    case .GetAsset:
        if let parameters = parameters, assetIdentifier = parameters.first {
            if parameters.count > 1 {
                let assetRevision = parameters[1]
                AssetCommand().getLatestByRevison(assetIdentifier, revision: assetRevision)
            } else {
                AssetCommand().getById(assetIdentifier)
            }
        } else {
            print("Error executing command, format should be: romecli -o get-asset -p AssetName 1.0 or romecli -o get-asset -p 5724c65da9e0520f5aa25984")
            return
        }
    case .AddAsset:
        if let parameters = parameters, assetName = parameters.first {
            let assetRevision = parameters[1]
            let assetPath = parameters[2]
            AssetCommand().addAsset(assetName, revision: assetRevision, path: assetPath)
        } else {
            print("Error executing command, format should be: romecli -o add-asset -p AssetName 1.0 /Users/alex/asset.zip")
            return
        }
    case .DeleteAsset:
        if let parameters = parameters, assetId = parameters.first {
            print("Deleting Asset with id:", assetId)
            AssetCommand().delete(assetId)
        } else {
            print("Error executing command, format should be: romecli -o delete-asset -p 5724c65da9e0520f5aa25984")
            return
        }
    case .UpdateAsset:
        if let parameters = parameters, assetId = parameters.first, assetActive = parameters[1].boolValue() {
            print("Updating Asset with id:", assetId, "to", assetActive.description)
            AssetCommand().update(assetId, active: assetActive)
        } else {
            print("Error executing command, format should be: romecli -o update-asset -p 5724c65da9e0520f5aa25984 true")
            return
        }
    }
}

enum Operation: String {
    case AddClient      = "add-client"
    case DeleteClient   = "delete-client"
    case ListClients    = "list-clients"
    case AddAsset       = "add-asset"
    case DeleteAsset    = "delete-asset"
    case GetAsset       = "get-asset"
    case ListAssets     = "list-assets"
    case UpdateAsset    = "update-asset"
}

let cli = CommandLine()
let operation = EnumOption<Operation>(shortFlag: "o",
                                      longFlag: "operation",
                                      required: false,
                                      helpMessage: "Operation methods")

let parameters = MultiStringOption(shortFlag: "p",
                                   longFlag: "parameters",
                                   required: false,
                                   helpMessage: "Parameters")

let help = BoolOption(shortFlag: "h",
                      longFlag: "help",
                      helpMessage: "Gives a list of supported operations")

cli.setOptions(operation, parameters, help)

do {
    try cli.parse()
    if (help.value) {
        HelpCommand().printHelp()
    } else {
        startOperation(operation.value, parameters: parameters.value)
    }
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}