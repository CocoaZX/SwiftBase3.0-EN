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
    
    open func value(forKey key: String) -> CacheItem? {
        return CacheItem.em.object(primaryKey: key as AnyObject)
    }
    
    open func setValue(_ value: CacheItem) {
        CacheItem.em.save(value)
    }
    
    open func string(forKey key: String) -> String? {
        return value(forKey: key)?.value
    }
    
    open func setString(_ value: String, forKey key: String, expires: Double?) {
        let item = CacheItem()
        item.key = key
        item.value = value
        item.expires = expires ?? Date.distantFuture.timeIntervalSince1970
        setValue(item)
    }
    
    open func remove(forKey key: String) {
        guard let item = value(forKey: key) else { return }
        CacheItem.em.delete(item)
    }
    
    open func clear() {
        CacheItem.em.deleteAll()
    }
}
