
/// Wrapping types for the map function.
public enum Wrapping {
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

extension BidirectionalCollection {


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
	func paired(with wrapping: Wrapping = .none) -> AnySequence<(Element, Element)> {

		// There needs to be more than 1 element
		// to create one pair.
		guard
			count > 1,
			let first = first,
			let last = last
		else {
			return AnySequence { AnyIterator { nil } }
		}

		var zippedIterator = zip(self, dropFirst()).makeIterator()
		var isInitialFirstIteration = true
		var isInitialLastIteration = true

		// Replace AnySequence with custom struct that conforms to sequence
		// makeIterator
		// Custom Iterator
		//

		return AnySequence {

			return AnyIterator {

				if wrapping == .lastElementFirst && isInitialFirstIteration {

					isInitialFirstIteration = false
					return (last, first)

				} else if let next = zippedIterator.next() {

					return next

				} else if wrapping == .firstElementLast && isInitialLastIteration {

					isInitialLastIteration = false
					return (last, first)
				}

				return nil
			}
		}
	}
}
