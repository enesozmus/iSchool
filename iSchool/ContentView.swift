//
//  ContentView.swift
//  iSchool
//
//  Created by enesozmus on 20.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    // Get a reference to the CoreDataStack from the environment.
    @EnvironmentObject var coreDataStack : CoreDataStack
    // Get a reference to the managed object context from the environment.
    @Environment(\.managedObjectContext) private var viewContext
    // Get schools
    @FetchRequest(sortDescriptors: []) var schools: FetchedResults<School>
    
    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    List {
                        ForEach(schools) { school in
                            NavigationLink {
                                //Text("DetailView")
                                DetailView(school: school)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(school.name ?? "")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                        .padding()
                                        .background(.pink, in: RoundedRectangle(cornerRadius: 12))
                                }
                            }
                        }
                        .onDelete(perform: deleteSchool)
                        
                        Button {
                            addARandomSchool()
                        } label: {
                            Text("Add a random school for test")
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("iSchool")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        coreDataStack.databaseSeeding()
                    } label: {
                        Text("Database seeding")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        coreDataStack.deleteAll()
                    } label: {
                        Text("Remove all")
                    }
                }
            }
        }
    }
    
    //
    func addARandomSchool() {
        let newSchool = School(context: viewContext)
        newSchool.id = UUID()
        newSchool.name = "A Random School"
        newSchool.address = ""
        newSchool.date = Date()
        coreDataStack.save()
    }
    func deleteSchool(offsets : IndexSet) {
        offsets.map { schools[$0] }.forEach(viewContext.delete)
        coreDataStack.save()
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
        .environmentObject(CoreDataStack.shared)
}
