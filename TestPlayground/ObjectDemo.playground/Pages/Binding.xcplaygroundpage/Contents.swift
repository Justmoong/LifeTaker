//: [Previous](@previous)

import Foundation
import Combine

struct StructModel {
    var text: String = "Struct"
}

class ClassModel: ObservableObject {
    
    @Published var instance = StructModel()
    var text = "Class"

    func updateStructModel() {
        instance.text = text
    }
}


var structModelInstance = StructModel()
var classModelInstance = ClassModel()

var classModelChild: ClassModel

classModelInstance.updateStructModel()

print(structModelInstance.text)
print(classModelInstance.text)
