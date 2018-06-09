
extension Array {

	/// Wrapping types for the map function.
	enum Wrapping {
		/// Doesn't wrap at all.
		///
		/// When used the resulting array will be one
		/// element shorter than the input array.
		case none

		/// Duplicates the last element as the first.
		case lastElementFirst

		/// Duplicates the first element as the last.
		case firstElementLast
	}

	/// Provides an array of paired elements.
	///
	/// Takes consecutive elements and pairs them up so that
	/// they can be iterated for times when you need to work
	/// with the current and next elements in an array.
	///
	/// Using .none for the wrapping with result in an array one
	/// element shorter than the input.
	///
	/// The option .lastElementFirst will duplicate either the
	/// last element in the receiver as the first item in the
	/// first pairing, with the second item being the first element
	/// in the receiver.
	///
	/// The option .firstElementLast acts as above but instead
	/// duplicates the first element into the last pairing.
	///
	/// - Parameter wrapping: The wrapping option to use.
	/// - Returns: An array of tuples of paired elements from the receiver.
	func paired(with wrapping: Wrapping = .none) -> [(Element, Element)] {

		// There needs to be more than 1 element
		// to create one pair.
		guard count > 1 else {
			return []
		}

		var previous: Element
		var elements: [Element] = self

		switch wrapping {

			case .none:

				let initial = elements.removeFirst()
				previous = initial

			case .firstElementLast:

				let initial = elements.removeFirst()
				elements.append(initial)
				previous = initial

			case .lastElementFirst:

				// This is fine, already tested for more than 1 element.
				previous = last!
		}

		return elements.map { next in
			let pair = (previous, next)
			previous = next
			return pair
		}
	}
}
