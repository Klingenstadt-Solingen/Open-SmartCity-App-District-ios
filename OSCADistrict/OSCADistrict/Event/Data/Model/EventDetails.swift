class EventDetails {
    var prices: [EventPrice]
    var addressLocality: String
    var name: String
    var postalCode: String
    var streetAdress: String
    var description: String
    
    init(_ event: Event) {
        let location = event.object(forKey: "location") as? Dictionary<String, Any>
        let adress = location?["address"] as? Dictionary<String, Any>
        self.addressLocality = adress?["addressLocality"] as? String ?? ""
        self.name = adress?["name"] as? String ?? ""
        self.postalCode = adress?["postalCode"] as? String ?? ""
        self.streetAdress = adress?["streetAddress"] as? String ?? ""
        
        self.description = event.object(forKey: "description") as? String ?? ""
        
        var castedPrices: [EventPrice] = []
        let offers = event.object(forKey: "offers") as? [Dictionary<String, Any>]
        offers?.forEach() { offer in
            let name = offer["name"] as? String
            let price = offer["price"] as? String
            let priceCurrency = offer["priceCurrency"] as? String
            castedPrices.append(EventPrice(name: name ?? "", price: price ?? "", priceCurrency: priceCurrency ?? ""))
        }
        
        self.prices = castedPrices
    }
}
