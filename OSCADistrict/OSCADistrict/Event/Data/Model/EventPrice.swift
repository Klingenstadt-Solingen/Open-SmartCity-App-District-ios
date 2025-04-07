struct EventPrice: Equatable, Hashable {
    var name: String
    var price: String
    var priceCurrency: String
    
    init(name: String, price: String, priceCurrency: String) {
        self.name = name
        self.price = price
        self.priceCurrency = priceCurrency
    }
}
