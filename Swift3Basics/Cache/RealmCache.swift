//
//  RealmCache.swift
//  SwiftBasics
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

open class RealmCache: Cachable {
    
    public init(){
        
    }
    
    public func value(forKey key: String) -> CacheItem? {
        
        return CacheItem.em.object(primaryKey: key as AnyObject)
    }
    
    public func setValue(_ value: CacheItem) {
        CacheItem.em.save(value)
    }
    
    public func string(forKey key: String) -> String? {
        
        return value(forKey: key)?.value
    }
    
    public func setString(_ value: String, forKey key: String, expires: Double?) {
        let item = CacheItem()
        item.key = key
        item.value = value
        item.expires = expires ?? Date.distantFuture.timeIntervalSince1970
        setValue(item)
    }
    
    public func remove(forKey key: String) {
        guard let item = value(forKey: key) else { return }
        CacheItem.em.delete(item)
    }
    
    public func clear() {
        CacheItem.em.deleteAll()
    }
}
