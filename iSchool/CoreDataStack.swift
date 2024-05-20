//
//  CoreDataStack.swift
//  iSchool
//
//  Created by enesozmus on 20.05.2024.
//

import CoreData
import Foundation

// Define an observable class to encapsulate all Core Data-related functionality.
class CoreDataStack: ObservableObject {
    static let shared: CoreDataStack = CoreDataStack()
    
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "DataModel")
        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container;
    }()
    
    private init() { }
    
    // 🚨
    func databaseSeeding() {
        let viewContext = persistentContainer.viewContext
        
        let hogwarts = School(context: viewContext)
        hogwarts.id = UUID()
        hogwarts.name = "Hogwarts School of Witchcraft and Wizardry"
        hogwarts.address = "Scottish Highlands, United Kingdom"
        hogwarts.date = Date()
        
        let aurora = School(context: viewContext)
        aurora.id = UUID()
        aurora.name = "Aurora Academy"
        aurora.address = "Lower Silesia, Poland"
        aurora.date = Date()
        
        let principal1 = Principal(context: viewContext)
        principal1.id = UUID()
        principal1.name = "Albus Dumbledore"
        principal1.date = Date()
        principal1.age = 115
        principal1.experience = 24
        principal1.school = hogwarts
        
        let principal2 = Principal(context: viewContext)
        principal2.id = UUID()
        principal2.name = "Vesemir"
        principal2.date = Date()
        principal2.age = 97
        principal2.experience = 48
        principal2.school = aurora
        
        let teacher1 = Teacher(context: viewContext)
        teacher1.id = UUID()
        teacher1.name = "Minerva McGonagall"
        teacher1.age = 55
        teacher1.experience = 13
        teacher1.date = Date()
        teacher1.principal = principal1
        teacher1.school = hogwarts
        
        let teacher2 = Teacher(context: viewContext)
        teacher2.id = UUID()
        teacher2.name = "Severus Snape"
        teacher2.age = 45
        teacher2.experience = 12
        teacher2.date = Date()
        teacher2.principal = principal1
        teacher2.school = hogwarts
        
        let teacher3 = Teacher(context: viewContext)
        teacher3.id = UUID()
        teacher3.name = "Pomona Sprout"
        teacher3.age = 45
        teacher3.experience = 12
        teacher3.date = Date()
        teacher3.principal = principal1
        teacher3.school = hogwarts
        
        let teacher4 = Teacher(context: viewContext)
        teacher4.id = UUID()
        teacher4.name = "Rubeus Hagrid"
        teacher4.age = 42
        teacher4.experience = 11
        teacher4.date = Date()
        teacher4.principal = principal2
        teacher4.school = aurora
        
        let teacher5 = Teacher(context: viewContext)
        teacher5.id = UUID()
        teacher5.name = "Gilderoy Lockhart"
        teacher5.age = 47
        teacher5.experience = 4
        teacher5.date = Date()
        teacher5.principal = principal2
        teacher5.school = aurora
        
        let student1 = Student(context: viewContext)
        student1.id = UUID()
        student1.name = "Hermione Granger"
        student1.age = 12
        student1.standard = 4
        student1.date = Date()
        student1.school = hogwarts
        student1.principal = principal1
        student1.teachers = [teacher1, teacher2, teacher3]
        
        let student2 = Student(context: viewContext)
        student2.id = UUID()
        student2.name = "Percy Weasley"
        student1.age = 14
        student1.standard = 6
        student1.date = Date()
        student1.school = hogwarts
        student1.principal = principal1
        student1.teachers = [teacher1, teacher2, teacher3]
        
        
        let student3 = Student(context: viewContext)
        student3.id = UUID()
        student3.name = "Neville Longbottom"
        student3.age = 12
        student3.standard = 4
        student3.date = Date()
        student3.school = hogwarts
        student3.principal = principal1
        student3.teachers = [teacher1, teacher2, teacher3]
        
        let student4 = Student(context: viewContext)
        student4.id = UUID()
        student4.name = "Harry Potter"
        student4.age = 12
        student4.standard = 4
        student4.date = Date()
        student4.school = hogwarts
        student4.principal = principal1
        student4.teachers = [teacher1, teacher2, teacher3]
        
        let student5 = Student(context: viewContext)
        student5.id = UUID()
        student5.name = "Ginny Weasley"
        student5.age = 9
        student5.standard = 1
        student5.date = Date()
        student5.school = hogwarts
        student5.principal = principal1
        student5.teachers = [teacher1, teacher2, teacher3]
        
        let student6 = Student(context: viewContext)
        student6.id = UUID()
        student6.name = "Eskel"
        student6.age = 12
        student6.standard = 4
        student6.date = Date()
        student6.school = aurora
        student6.principal = principal2
        student6.teachers = [teacher4, teacher5]
        
        let student7 = Student(context: viewContext)
        student7.id = UUID()
        student7.name = "Lambert"
        student7.age = 12
        student7.standard = 4
        student7.date = Date()
        student7.school = aurora
        student7.principal = principal2
        student7.teachers = [teacher4, teacher5]
        
        let student8 = Student(context: viewContext)
        student8.id = UUID()
        student8.name = "Reinald"
        student8.age = 11
        student8.standard = 3
        student8.date = Date()
        student8.school = aurora
        student8.principal = principal2
        student8.teachers = [teacher4, teacher5]
        
        let student9 = Student(context: viewContext)
        student9.id = UUID()
        student9.name = "Luka"
        student9.age = 13
        student9.standard = 5
        student9.date = Date()
        student9.school = aurora
        student9.principal = principal2
        student9.teachers = [teacher4, teacher5]
        
        let student10 = Student(context: viewContext)
        student10.id = UUID()
        student10.name = "Gweld"
        student10.age = 11
        student10.standard = 2
        student10.date = Date()
        student10.school = aurora
        student10.principal = principal2
        student10.teachers = [teacher4, teacher5]
        
        save()
    }
    
    // 🚨
    func deleteAll() {
        let fetchRequest = School.fetchRequest()
        let items = try? persistentContainer.viewContext.fetch(fetchRequest)
        for item in items ?? [] {
            persistentContainer.viewContext.delete(item)
        }
        save()
    }
    
    // 🚨
    // Add a convenience method to commit changes to the store.
    func save() {
        // Verify that the context has uncommitted changes.
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            // Attempt to save changes.
            try persistentContainer.viewContext.save()
        } catch {
            // Handle the error appropriately.
            print("Failed to save the context:", error.localizedDescription)
        }
    }
}
