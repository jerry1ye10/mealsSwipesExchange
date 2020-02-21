import UIKit
print(10)
class Student {

    var nameStudent: String

    var schoolStudent: String?

    var majorStudent: String?

    

    init(name:String, school:String, major: String) {

        self.nameStudent = name

        self.schoolStudent = school

        self.majorStudent = major

    }

    

   init(name: String) {

          self.nameStudent = name

      }

    

    //babyQuaker.name = "lol"

}
print(10)
var me = Student(name: "ranbir", school: "Wharton", major:"Major.mgmt")

me.nameStudent = "jordan"
print(me.nameStudent)
