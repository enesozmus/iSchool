//
//  DetailView.swift
//  iSchool
//
//  Created by enesozmus on 21.05.2024.
//

import SwiftUI

struct DetailView: View {
    
    // Get a reference to the CoreDataStack from the environment.
    @EnvironmentObject var coreDataStack : CoreDataStack
    // Get a reference to the managed object context from the environment.
    @Environment(\.managedObjectContext) private var viewContext
    
    let school : School
    var teachers : [Teacher]
    var students : [Student]
    var principal : [Principal] = []
    
    @State private var showingAddPrincipal : Bool = false
    @State private var showingAddTeacher : Bool = false
    @State private var showingAddStudent : Bool = false
    
    init(school: School) {
        self.school = school
        
        // one to many
        self.teachers  = school.teachers?.allObjects as! [Teacher]
        self.teachers = self.teachers.sorted(by: {$0.date! < $1.date!})
        self.students = school.students?.allObjects as! [Student]
        self.students = self.students.sorted(by: { $0.date! < $1.date! })
        
        // one to one
        if let _principal = school.principal {
            self.principal.append(_principal)
        }
    }
    
    var body: some View {
        Form {
            Section (header: Text("Principal")) {
                List {
                    ForEach(principal) { princ in
                        NavigationLink  {
                            //PrincipalDetailView(principal: princ)
                            Text("PrincipalDetailView")
                        } label: {
                            Label(school.principal?.name ?? "", systemImage: "star.fill")
                        }
                    }
                    .onDelete(perform: deletePrincipal)
                    Button  {
                        self.showingAddPrincipal = true
                    } label: {
                        Text("Add Principal")
                    }
                }
            }
            Section (header: Text("Teachers")) {
                List {
                    ForEach(teachers) { teacher in
                        NavigationLink {
                            //TeacherDetailView(teacher: teacher)
                            Text("TeacherDetailView")
                        } label: {
                            Label(teacher.name ?? "", systemImage: "bolt.fill")
                        }
                    }
                    .onDelete(perform: deleteTeacher)
                    Button  {
                        self.showingAddTeacher = true
                    } label: {
                        Text("Add Teacher")
                    }
                }
            }
            Section (header: Text("Students")) {
                List {
                    ForEach(students) { student in
                        NavigationLink {
                            //StudentDetailView(student: student)
                            Text("StudentDetailView")
                        } label: {
                            Label(student.name ?? "", systemImage: "heart.fill")
                        }
                    }
                    .onDelete(perform: deleteStudent)
                    Button  {
                        self.showingAddStudent = true
                    } label: {
                        Text("Add Student")
                    }
                }
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddPrincipal) {
            //AddNewPrincipalView(school: self.school)
            Text("AddNewPrincipalView")
        }
        .sheet(isPresented: $showingAddTeacher) {
            //AddNewTeacherView(school: self.school)
            Text("AddNewTeacherView")
        }
        .sheet(isPresented: $showingAddStudent) {
            //AddNewStudentView(school: self.school)
            Text("AddNewStudentView")
        }
    }
    
    //Function to remove individual items
    func deletePrincipal(offsets : IndexSet) {
        offsets.map { principal[$0] }.forEach(viewContext.delete)
        coreDataStack.save()
    }
    func deleteTeacher(offsets : IndexSet) {
        offsets.map { teachers[$0] }.forEach(viewContext.delete)
        coreDataStack.save()
    }
    func deleteStudent(offsets : IndexSet) {
        offsets.map { students[$0] }.forEach(viewContext.delete)
        coreDataStack.save()
    }
}

#Preview {
    DetailView(school: School(context: CoreDataStack.shared.persistentContainer.viewContext))
        .environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
        .environmentObject(CoreDataStack.shared)
}
