//
//  Cache.swift
//  SwiftBasics
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - Cachable

public protocol Cachable {
    
    func value(forKey key: String) -> CacheItem?
    
    func setValue(_ value: CacheItem)
    
    func string(forKey key: String) -> String?
    
    func setString(_ value: String, forKey key: String, expires: Double?)
    
    func remove(forKey key: String)
    
    func clear()
}


// MARK: - CacheManager

open class CacheManager {
    
    let cachable: Cachable
    
    public init(cachable: Cachable) {
        self.cachable = cachable
    }
    
    // MARK: - Methods
    
    public func object<T: Mappable>(forKey key: String) -> T? {
        guard let content: String = cachable.string(forKey: key) else { return nil }
        return Mapper<T>().map(JSONString: content)
    }
    
    public func setObject<T: Mappable>(_ object: T, forKey key: String, expires: Double? = nil) {
        guard let jsonString = Mapper<T>().toJSONString(object) else { return }
        cachable.setString(jsonString, forKey: key, expires: expires)
    }
    
    public func remove(forKey key: String) {
        cachable.remove(forKey: key)
    }
    
    // MARK: - Subscript
    
    public subscript(key: String) -> CacheItem? {
        get {
            return cachable.value(forKey: key)
        }
        set {
            if let value = newValue {
                value.key = key
                cachable.setValue(value)
            }
        }
    }
    
    public subscript(key: String) -> String? {
        get {
            return cachable.string(forKey: key)
        }
        set {
            if let string = newValue {
                cachable.setString(string, forKey: key, expires: nil)
            }
        }
    }
    
    public subscript(key: String) -> Int? {
        get {
            return cachable.string(forKey: key)?.integer
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: key, expires: nil)
            }
        }
    }
    
    public subscript(key: String) -> Float? {
        get {
            return cachable.string(forKey: key)?.float
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: key, expires: nil)
            }
        }
    }
    
    public subscript(key: String) -> Double? {
        get {
            return cachable.string(forKey: key)?.double
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: key, expires: nil)
            }
        }
    }
    
    public subscript(key: String) -> Bool? {
        get {
            return cachable.string(forKey: key)?.bool
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: key, expires: nil)
            }
        }
    }
    
}
