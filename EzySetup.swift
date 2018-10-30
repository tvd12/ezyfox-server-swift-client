//
//  EzySetup.swift
//  hello-swift
//
//  Created by Dung Ta Van on 10/30/18.
//  Copyright © 2018 Young Monkeys. All rights reserved.
//

import Foundation

public class EzySetup {
    private let handlerManager: EzyHandlerManager
    private let appSetups : NSMutableDictionary
    
    public init(handlerManager: EzyHandlerManager) {
        self.handlerManager = handlerManager
        self.appSetups = NSMutableDictionary()
    }
    
    public func addDataHandler(cmd: String, dataHandler: EzyDataHandler) -> EzySetup {
        self.handlerManager.addDataHandler(cmd: cmd, dataHandler: dataHandler);
        return self;
    }
    
    public func addEventHandler(eventType: String, eventHandler: EzyEventHandler) -> EzySetup {
        self.handlerManager.addEventHandler(eventType: eventType, eventHandler: eventHandler);
        return self;
    }
    
    public func setupApp(appName: String) -> EzyAppSetup {
        var appSetup = self.appSetups[appName] as! EzyAppSetup?;
        if(appSetup == nil) {
            let appDataHandlers = self.handlerManager.getAppDataHandlers(appName: appName);
            appSetup = EzyAppSetup(dataHandlers: appDataHandlers, parent: self);
            self.appSetups[appName] = appSetup;
        }
        return appSetup!;
    }
}

public class EzyAppSetup {
    private let parent : EzySetup
    private let dataHandlers : EzyAppDataHandlers
    
    public init(dataHandlers: EzyAppDataHandlers, parent: EzySetup) {
        self.parent = parent
        self.dataHandlers = dataHandlers
    }
    
    public func addDataHandler(cmd: String, dataHandler: EzyAppDataHandler) -> EzyAppSetup {
        self.dataHandlers.addHandler(cmd: cmd, handler: dataHandler)
        return self
    }
    
    public func done() -> EzySetup {
        return self.parent
    }
}
