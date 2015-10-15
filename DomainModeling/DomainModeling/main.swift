//
//  main.swift
//  DomainModeling
//
//  Created by iGuest on 10/14/15.
//  Copyright (c) 2015 Alex Schenck. All rights reserved.
//

import Foundation

// Currency enumeration, double values represent relative conversion rates
enum Currency : Double {
    case USD = 2
    case GBP = 1
    case EUR = 3
    case CAN = 2.5
}

struct Money {
    var amount : Double
    var currency: Currency
    
    init(curr : Currency)
    {
        self.amount = 0
        self.currency = curr
    }
    
    init(amount : Double, curr : Currency)
    {
        self.amount = amount
        self.currency = curr
    }
    
    // Returns given amount of given desired currency from given currency with amount
    func convert(toCurr : Currency) -> Double
    {
        return (self.currency.rawValue / toCurr.rawValue) * self.amount
    }
    
    // Conducts given math Operation and returns result in this Money's currency
    func mathOperation(op: String, otherMoney : Money) -> Double
    {
        switch op {
            case "add":
                return self.amount + otherMoney.convert(self.currency)
            case "subtract":
                return self.amount - otherMoney.convert(self.currency)
            default:
                println("Not a vaild operation")
                return 0
        }
    }
}

// Test cases
var money1 = Money(amount: 15, curr: Currency.USD);
var money2 = Money(amount: 10, curr: Currency.CAN);

println(money1.convert(Currency.EUR))
println(money2.convert(Currency.GBP))
println(money1.mathOperation("add", otherMoney: money2))
println(money2.mathOperation("subtract", otherMoney: money1))
