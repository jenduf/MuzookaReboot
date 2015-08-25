//
//  APIOperation.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 8/24/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class APIOperation: NSOperation
{
    private var task: NSURLSessionDataTask!
    private var running: Bool = false
    
    // Controls if the task is finished or not
    private var done: Bool = false
    
    // MARK: Subclassed NSOperation Methods
    
    // Returns if the task is asynchronous or not.
    override public var asynchronous: Bool
    {
        return true
    }
    
    // Returns if the task is currently running.
    override public var executing: Bool
    {
        return running
    }
    
    // Returns if the task is finished.
    override public var finished: Bool
    {
        return done
    }
    
    // Starts the task
    public override func start()
    {
        if self.cancelled
        {
            self.willChangeValueForKey("isFinished")
            self.done = true
            self.didChangeValueForKey("isFinished")
            
            return
        }
        
        self.willChangeValueForKey("isExecuting")
        self.willChangeValueForKey("isFinished")
        
        self.running = true
        self.done = false
        
        self.didChangeValueForKey("isExecuting")
        self.didChangeValueForKey("isFinished")
        
        self.task.resume()
    }
    
    // Cancels the running task
    public override func cancel()
    {
        super.cancel()
        self.task.cancel()
    }
    
    // Sets the task to finished
    public func finish()
    {
        self.willChangeValueForKey("isExecuting")
        self.willChangeValueForKey("isFinished")
        
        self.running = false
        self.done = true
        
        self.didChangeValueForKey("isExecuting")
        self.didChangeValueForKey("isFinished")
    }
   
}
