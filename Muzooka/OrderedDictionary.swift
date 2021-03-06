
//
//  OrderedDictionary.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

public struct OrderedDictionary <KeyType: Hashable, ValueType>
{
	typealias ArrayType = [KeyType]
	typealias DictionaryType = [KeyType: ValueType]
	
	var array = ArrayType()
	var dictionary = DictionaryType()
	
	var count: Int
	{
		return self.array.count
	}
	
	func getKeyForIndex(index: Int) -> String
	{
		let key = self.array[index]
		return key as! String
	}
	
	mutating func insert(value: ValueType,
					 forKey key: KeyType,
					 atIndex index: Int) -> ValueType?
	{
		var adjustedIndex = index
		
		let existingValue = self.dictionary[key]
		
		if existingValue != nil
		{
			let existingIndex = find(self.array, key)!
			
			if existingIndex < index
			{
				adjustedIndex--
			}
			
			self.array.removeAtIndex(existingIndex)
		}
		
		self.array.insert(key, atIndex: adjustedIndex)
		self.dictionary[key] = value
		
		return existingValue
	}
	
	mutating func removeAtIndex(index: Int) -> (KeyType, ValueType)
	{
		precondition(index < self.array.count, "Index out-of-bounds")
		
		let key = self.array.removeAtIndex(index)
		
		let value = self.dictionary.removeValueForKey(key)!
		
		return (key, value)
	}
	
	subscript(key: KeyType) -> ValueType?
	{
		get
		{
			return self.dictionary[key]
		}
		
		set
		{
			if let index = find(self.array, key)
			{
				
			}
			else
			{
				self.array.append(key)
			}
			
			self.dictionary[key] = newValue
		}
		
	}
	
	subscript(index: Int) -> (KeyType, ValueType)
	{
		get
		{
			precondition(index < self.array.count, "Index out-of-bounds")
			
			let key = self.array[index]
			
			let value = self.dictionary[key]!
			
			return (key, value)
		}
		
		set
		{
			precondition(index < self.array.count, "Index out-of-bounds")
			
			let (key, value) = newValue
			
			let originalKey = self.array[index]
			
			self.dictionary[originalKey] = nil
			
			self.array[index] = key
			
			self.dictionary[key] = value			
		}
	}
}
