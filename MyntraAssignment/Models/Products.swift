
import Foundation
struct Products : Codable {
	let name : String?
	let sub_category : [ProductsCategory]?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case sub_category = "sub_category"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		sub_category = try values.decodeIfPresent([ProductsCategory].self, forKey: .sub_category)
	}

}
