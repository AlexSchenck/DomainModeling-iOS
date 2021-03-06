//
//  main.swift
//  DomainModeling
//
//  Created by iGuest on 10/14/15.
//  Copyright (c) 2015 Alex Schenck. All rights reserved.
//

import Foundation

// Currency enumeration, double values represent relative conversion rates
enum Currency : Double
{
    case USD = 2
    case GBP = 1
    case EUR = 3
    case CAN = 2.5
}

struct Money
{
    var amount : Double
    var currency: Currency
    
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
var money3 = Money(amount: 5, curr: Currency.GBP);
var money4 = Money(amount: 12, curr: Currency.EUR);

println("Money test cases")
println(money1.convert(Currency.EUR))
println(money2.convert(Currency.GBP))
println(money3.convert(Currency.CAN))
println(money4.convert(Currency.USD))
println(money1.mathOperation("add", otherMoney: money2))
println(money2.mathOperation("subtract", otherMoney: money3))
println(money1.mathOperation("add", otherMoney: money4))
println(money2.mathOperation("subtract", otherMoney: money1))

class Job
{
    var title : String
    var salary : Double
    var salaryIsPerHour : Bool
    
    init (title : String, salary : Double, salaryIsPerHour : Bool)
    {
        self.title = title
        self.salary = salary
        self.salaryIsPerHour = salaryIsPerHour
    }
    
    // Returns calculated income based on given number of hours worked
    // If this job's salary is per year, hours worked can be nil
    func calculateIncome(hoursWorked : Double?) -> Double
    {
        if self.salaryIsPerHour == true
        {
            if hoursWorked != nil
            {
                return salary * hoursWorked!
            }
            else
            {
                return 0
            }
        }
        else
        {
            return salary
        }
    }
    
    // Increases salary by given percentage and returns new salary
    func raise(percentIncrease : Double) -> Double
    {
        self.salary += self.salary * (percentIncrease / 100)
        return self.salary
    }
}

// Test cases
var job1 = Job(title: "Developer", salary: 30, salaryIsPerHour: true)
var job2 = Job(title: "Designer", salary: 50000, salaryIsPerHour: false)

println("Job test cases")
println(job1.calculateIncome(200))
println(job1.raise(15))
println(job1.calculateIncome(200))
println(job2.calculateIncome(nil))
println(job2.raise(10))
println(job2.calculateIncome(nil))

class Person
{
    var firstName : String
    var lastName : String
    var age : Int
    var job : Job?
    var spouse : Person?
    
    init(firstName : String, lastName : String, age : Int, job : Job?, spouse : Person?)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        
        if age < 16
        {
            self.job = nil
            self.spouse = nil
        }
        else
        {
            self.job = job
            
            if age < 18
            {
                self.spouse = nil
            }
            else
            {
                self.spouse = spouse
            }
        }
    }
    
    // String representation of this person
    func toString() -> String
    {
        var result : String = ""
        result += "\(firstName) \(lastName) is \(age) years old.\n"
        
        if job == nil
        {
            result += "\(firstName) does not have a job.\n"
        }
        else
        {
            result += "\(firstName) is a \(job!.title).\n"
        }
        
        if spouse == nil
        {
            result += "\(firstName) is single."
        }
        else
        {
            result += "\(firstName)'s spouse is \(spouse!.firstName) \(spouse!.lastName)."
        }
        
        return result
    }
}

// Test cases
println("Person test cases")
var Bob = Person(firstName: "Bob", lastName: "Smith", age: 45, job: nil, spouse: nil)
var Mary = Person(firstName: "Mary", lastName: "Smith", age: 43, job: job1, spouse: Bob)

println(Mary.toString())

class Family
{
    var members : [Person]
    
    init(members : [Person])
    {
        var valid : Bool = false
        
        for var index = 0; index < members.count; index++
        {
            if members[0].age > 21
            {
                valid = true
            }
        }
        
        if valid == true
        {
            self.members = members
        }
        else
        {
            println("Family is not valid")
            self.members = []
        }
    }
    
    // Returns combined income of all family members
    func householdIncome() -> Double
    {
        var result : Double = 0
        
        for var index = 0; index < self.members.count; index++
        {
            var currentJob : Job? = members[index].job
            
            if currentJob != nil
            {
                result += currentJob!.salary
            }
        }
        
        return result
    }
    
    // Appends new child with age of 0 with given name to family list
    func haveChild(firstName : String, lastName : String)
    {
        println("\(firstName) \(lastName) is born! Congrats!")
        members.append(Person(firstName: firstName, lastName: lastName, age: 0, job: nil, spouse: nil))
    }
}

// Test cases
var family1 = Family(members: [Bob, Mary])

println(family1.householdIncome())
family1.haveChild("Clyde", lastName: "Smith")
