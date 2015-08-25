//
//  APIOperations.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 8/24/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

class APIOperations
{
    let apiRequest: APIRequest
    
    var requestState: APIRequest.RequestState.New
    
    init(request: APIRequest)
    {
        self.apiRequest = request
    }
}

class PendingOperations
{
    lazy var requestsInProgress = [Int : NSOperation]()
    lazy var requestsQueue: NSOperationQueue =
    {
        var queue = NSOperationQueue()
        queue.name = "Requests Queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
