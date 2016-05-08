import Foundation
import RomeKit

struct AssetCommand {
    
    func list() {
        
        let dispatchGroup = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_enter(dispatchGroup)
        
        RomeKit.Assets.all(queue, completionHandler: { (assets, error) in
            
            if let assets = assets {
                for asset in assets {
                    self.printAsset(asset)
                }
            }
            
            dispatch_group_leave(dispatchGroup)
        })
        
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
    }
    
    func getById(id: String) {
        
        let dispatchGroup = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_enter(dispatchGroup)
        
        RomeKit.Assets.getAssetById(id, queue: queue, completionHandler: { (asset, errors) in
            if let asset = asset {
                self.printAsset(asset)
            } else {
                print("Asset not found")
            }
            
            dispatch_group_leave(dispatchGroup)
        })
        
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
    }
    
    func getLatestByRevison(name: String, revision: String) {
        
        let dispatchGroup = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_enter(dispatchGroup)
        
        RomeKit.Assets.getLatestAssetByRevision(name, revision: revision, queue: queue, completionHandler: { (asset, errors) in
            if let asset = asset {
                self.printAsset(asset)
            }
            
            dispatch_group_leave(dispatchGroup)
        })
        
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
    }
    
    func addAsset(name: String, revision: String, path: String) {
        
        let dispatchGroup = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_enter(dispatchGroup)
        
        guard let data = NSData(contentsOfFile: path) else {
            print("File not found")
            return
        }
        
        RomeKit.Assets.create(name, revision: revision, data: data, queue: queue, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
            
            let currentPercent = Int(Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) * 100)
            print(currentPercent, "%")
            
            }, completionHandler: { (asset, error) in
                
                if let asset = asset {
                    self.printAsset(asset)
                }
                
                dispatch_group_leave(dispatchGroup)
                
        })
            
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
    }
    
    func delete(id: String) {
        
        let dispatchGroup = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_enter(dispatchGroup)
        
        RomeKit.Assets.delete(id, queue: queue, completionHandler: { (deleted, errors) in
            if (deleted != nil) {
                print("Asset deleted")
            } else {
                print("Error deleting asset")
            }
            dispatch_group_leave(dispatchGroup)
        })
        
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
    }
    
    func update(id: String, active: Bool) {
        
        let dispatchGroup = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_enter(dispatchGroup)
        
        RomeKit.Assets.updateStatus(id, active: active, queue: queue, completionHandler: { (updated, errors) in
            if (updated != nil) {
                print("Asset updated")
            } else {
                print("Error updating asset")
            }
            dispatch_group_leave(dispatchGroup)
        })
        
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
    }
    
    func printAsset(asset: Asset) {
        print("Id: " + asset.id!)
        print("Name: " + asset.name!)
        print("Revision: " + asset.revision!)
        print("File Extension: " + asset.file_extension!)
        print("Active: " + asset.active!.description)
        print("Created At: " + asset.created_at!.description)
        print("Updated At: " + asset.updated_at!.description)
        print("")
    }
    
}
