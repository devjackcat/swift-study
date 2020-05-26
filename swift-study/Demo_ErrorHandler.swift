//
//  Demo_ErrorHandler.swift
//  swift-study
//
//  Created by 永平 on 2020/5/19.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class Demo_ErrorHandler {
    
    //4种处理错误方式
    
    func run() {
        
        defer {
            print("执行清理1")
        }
        defer {
            print("执行清理2")
        }
        defer {
            print("执行清理3")
        }
        defer {
            print("执行清理4")
        }
        
        let vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 1
        do {
            try vendingMachine.vend(itemNamed: "Chips")
            print("购买成功")
        } catch VendingMachineError.invalidSelection {
            print("选择错误")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
            print("余额不足,需要\(coinsNeeded)")
        } catch {
            print("库存不足")
        }
    }
}

struct Item {
    var price: Int
    var count: Int
}

class Item2 {
    var price: Int = 0
    var count: Int = 0
    init(price: Int,count: Int) {
        self.price = price
        self.count = count
    }
}

class VendingMachine {
    
    var inventory = [
        "Candy Bar": Item(price: 12,count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pertzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func vend(itemNamed name:String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}
