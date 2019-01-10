//
// Расширения UIKit компонентов
//

import  UIKit

// MARK: - UIViewController
extension UIViewController {
    // Рекурсия
    /**
      Рекурсивный поиск всех `T: UIView` удовлетворяющих условию фильтра
    
      - Parameters:
        - view: `UIView`, в котором необходимо выполнить поиск
        - filter: критерий, которому должны удовлетворять элементы, для попадания в выборку
        - item: элемент к которому применяется действие фильтра
    
      - Returns: возвращает коллекцию элементов наследуемых от `UIView` и удовлетворяющих критериям выборки
      */
    func views<T: UIView>(in view: UIView, withFilter filter: @escaping (_ item: T) -> Bool) -> [T] {
        var result = [T]()
        
        for view in view.subviews {
            result.append(contentsOf: views(in: view, withFilter: filter))
        }
        
        if let view = view as? T,
            filter(view) {
            result.append(view)
        }
        
        return result
    }
}

// MARK: - UIColor
extension UIColor {
    /// Инициирует `UIColor` из значения в HEX представлении
    ///
    /// - Parameter value: Значение в HEX
    convenience public init(hex value: Int) {
        self.init(hex: value, alpha: 1.0)
    }
    
    /// Инициирует `UIColor` из значения в HEX представлении
    ///
    /// - Parameter value: Значение в HEX
    /// - Parameter alpha: Альфа-канал (прозрачность) от 0.0, до 1.0
    convenience public init(hex value: Int, alpha: CGFloat) {
        let red = Double(value >> 16 & 0xFF) / 255.0
        let green = Double(value >> 8 & 0xFF) / 255.0
        let blue = Double(value >> 0 & 0xFF) / 255.0
        self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: alpha)
    }
}


// MARK: - String
extension String {
    var asPhoneNumber: String {

        var numbers = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        if numbers.count > 10 {
            numbers = String(numbers[String.Index(encodedOffset: 1)...])
        }
        
        return String(
            format: "%@ (%@) %@-%@-%@", "+7",
            numbers[0...2],
            numbers[3...5],
            numbers[6...7],
            numbers[8...9])
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    subscript (index: Int) -> String {
        let index = self.index(startIndex, offsetBy: index)
        return String(self[index])
    }
}
