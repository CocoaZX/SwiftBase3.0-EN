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
    
    func value(forKey key: CacheManager.Key) -> CacheItem?
    
    func setValue(_ value: CacheItem)
    
    func string(forKey key: CacheManager.Key) -> String?
    
    func setString(_ value: String, forKey key: CacheManager.Key, expires: Double?)
    
    func remove(forKey key: CacheManager.Key)
    
    func clear()
}


// MARK: - CacheManager

open class CacheManager {
    
    public enum Key: String {
        
        case User = "_User"
        
        func suffixWith(_ suffix: AnyObject) -> String {
            return "\(self.rawValue)_\(suffix)"
        }
    }
    let cachable: Cachable
    
    
    public init(cachable: Cachable) {
        self.cachable = cachable
    }
    
    // MARK: - Methods
    
    public func object<T: Mappable>(forKey key: Key) -> T? {
        guard let content: String = cachable.string(forKey: key) else { return nil }
        return Mapper<T>().map(JSONString: content)
    }
    
    public func setObject<T: Mappable>(_ object: T, forKey key: Key, expires: Double? = nil) {
        guard let jsonString = Mapper<T>().toJSONString(object) else { return }
        cachable.setString(jsonString, forKey: key, expires: expires)
    }
    
    public func remove(forKey key: Key) {
        cachable.remove(forKey: key)
    }
    
    // MARK: - Subscript
    
    public subscript(key: Key) -> CacheItem? {
        get {
            return cachable.value(forKey: key)
        }
        set {
            if let value = newValue {
                value.key = key.rawValue
                cachable.setValue(value)
            }
        }
    }
    
    public subscript(stringkey: Key) -> String? {
        get {
            return cachable.string(forKey: stringkey)
        }
        set {
            if let string = newValue {
                cachable.setString(string, forKey: stringkey, expires: nil)
            }
        }
    }
    
    public subscript(intkey: Key) -> Int? {
        get {
            return cachable.string(forKey: intkey)?.integer
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: intkey, expires: nil)
            }
        }
    }
    
    public subscript(floatkey: Key) -> Float? {
        get {
            return cachable.string(forKey: floatkey)?.float
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: floatkey, expires: nil)
            }
        }
    }
    
    public subscript(doublekey: Key) -> Double? {
        get {
            return cachable.string(forKey: doublekey)?.double
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: doublekey, expires: nil)
            }
        }
    }
    
    public subscript(boolkey: Key) -> Bool? {
        get {
            return cachable.string(forKey: boolkey)?.bool
        }
        set {
            if let string = newValue?.string {
                cachable.setString(string, forKey: boolkey, expires: nil)
            }
        }
    }
    
}
