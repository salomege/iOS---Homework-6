import Cocoa

var greeting = "Hello, playground"

//1
class Book {
    var bookId: Int
    var title: String
    var author: String
    var isBorrowed: Bool

    init(bookId: Int, title: String, author: String, isBorrowed: Bool) {
        self.bookId = bookId
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }

    func markAsBorrowed() {
        isBorrowed = true
    }

    func markAsReturned() {
        isBorrowed = false
    }
}

class Owner {
    var ownerId: Int
    var name: String
    var borrowedBooks: [Book]

    init(ownerId: Int, name: String, borrowedBooks: [Book]) {
        self.ownerId = ownerId
        self.name = name
        self.borrowedBooks = borrowedBooks
    }

    func takeBookFromLibrary(book: Book) {
        if !book.isBorrowed {
            book.markAsBorrowed()
            borrowedBooks.append(book)
        }
    }

    func returnBookToLibrary(book: Book) {
        if book.isBorrowed {
            book.markAsReturned()
            if let index = borrowedBooks.firstIndex(where: {$0.bookId == book.bookId}) {
                borrowedBooks.remove(at: index)
            }
        }
    }
}

class Library {
    var books: [Book]
    var owners: [Owner]

    init(books: [Book], owners: [Owner]) {
        self.books = books
        self.owners = owners
    }

    func addBook(book: Book) {
        books.append(book)
    }

    func addOwner(owner: Owner) {
        owners.append(owner)
    }

    func findAvailableBooks() -> [Book] {
        return books.filter {!$0.isBorrowed}
    }

    func findBorrowedBooks() -> [Book] {
        return books.filter {$0.isBorrowed}
    }

    func findOwnerById(ownerID: Int) -> Owner? {
        return owners.first {$0.ownerId == ownerID}
    }

    func allowOwnerBorrowBook(owner: Owner, book: Book) {
        if !book.isBorrowed {
            owner.takeBookFromLibrary(book: book)
            book.markAsBorrowed()
        }
    }
}

let book1 = Book (bookId: 1, title: "Book 1", author: "Author 1", isBorrowed: false)
let book2 = Book (bookId: 2, title: "Book 2", author: "Author 2", isBorrowed: false)
let book3 = Book (bookId: 3, title: "Book 3", author: "Author 3", isBorrowed: false)

let owner1 = Owner(ownerId: 1, name: "Owner 1", borrowedBooks: [])
let owner2 = Owner(ownerId: 2, name: "Owner 2", borrowedBooks: [])

let library = Library(books: [book1, book2, book3], owners: [owner1, owner2])

library.allowOwnerBorrowBook(owner: owner1, book: book1)

let availableBooks = library.findAvailableBooks()
let borrowedBooks = library.findBorrowedBooks()

if let foundOwner = library.findOwnerById(ownerID: 1) {
    print("Owner found: \(foundOwner.name)")
} else {
    print("Owner not found")
}





//2
class Product {
    var productID: Int
    var name: String
    var price: Double

    init(productID: Int, name: String, price: Double) {
        self.productID = productID
        self.name = name
        self.price = price
    }
}

class Cart {
    var cartID: Int
    var items: [Product]

    init(cartID: Int, items: [Product]) {
        self.cartID = cartID
        self.items = items
    }

    func addItem(product: Product) {
        items.append(product)
    }

    func removeItem(product: Product) {
        if let index = items.firstIndex(where: {$0.productID == product.productID}) {
          items.remove(at: index)
        }
    }

    func calculateTotalPrice() -> Double {
        return items.reduce(0.0) { $0 + $1.price }
    }

    func clearCart() {
        items.removeAll()
    }
}

class User {
    var userID: Int
    var userName: String
    var cart: Cart

    init(userID: Int, userName: String, cart: Cart) {
        self.userID = userID
        self.userName = userName
        self.cart = cart
    }

    func addProductToCart(product: Product) {
        cart.addItem(product: product)
    }

    func removeProductFromCart(product: Product) {
        cart.removeItem(product: product)
    }

    func checkout() -> Double {
        let totalAmount = cart.calculateTotalPrice()
        cart.clearCart()
        return totalAmount
    }
}

let apple = Product (productID: 1, name: "Apple", price: 4.0)
let orange = Product (productID: 2, name: "Orange", price: 6.0)

let cart = Cart(cartID: 1, items: [])

let user = User(userID: 1, userName: "User 1", cart: cart)

user.addProductToCart(product: apple)
user.addProductToCart(product: orange)

let totalAmount = user.checkout()
print("\(user.userName) checked out. Total amount: GEL\(totalAmount)")
