import Foundation
import RomeKit

struct ClientCommand {
    
    func list() {
        
        let dispatchGroup = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_enter(dispatchGroup)
        
        RomeKit.Clients.all(queue, completionHandler: { (clients, error) in
            
            if let clients = clients {
                for client in clients {
                    print("Id: " + client.id!)
                    print("Name: " + client.name!)
                    print("Key: " + client.api_key!)
                    print("")
                }
            }
            
            dispatch_group_leave(dispatchGroup)
        })
        
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
    }
    
    func add(name: String) {
        
        let dispatchGroup = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_enter(dispatchGroup)
        
        RomeKit.Clients.create(name, queue: queue, completionHandler: { (client, error) in
            if let client = client {
                print("Created client with API Key:", client.api_key!)
            } else {
                print("Error creating client:", error.debugDescription)
            }
            dispatch_group_leave(dispatchGroup)
        })
        
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
    }
    
    func delete(id: String) {
        
        let dispatchGroup = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_enter(dispatchGroup)
        
        RomeKit.Clients.delete(id, queue: queue) { (deleted, error) in
            if (deleted != nil) {
                print("Client deleted")
            } else {
                print("Error deleting client")
            }
            dispatch_group_leave(dispatchGroup)
        }
        
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
        
    }
    
}