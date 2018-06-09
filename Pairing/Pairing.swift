
public struct PairedSequence<Collection: BidirectionalCollection> {

	private let collection: Collection
	private let wrapping: Wrapping

	fileprivate init(collection: Collection, wrapping: Wrapping) {
		self.collection = collection
		self.wrapping = wrapping
	}
}

extension PairedSequence {

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
}

extension PairedSequence {

	public struct Iterator {

		private let wrapping: Wrapping
		private let first: Collection.Element?
		private let last: Collection.Element?
		private var zippedIterator: Zip2Sequence<Collection, Collection.SubSequence>.Iterator
		private var isInitialFirstIteration = true
		private var isInitialLastIteration = true

		fileprivate init(collection: Collection, wrapping: Wrapping) {
			self.wrapping = wrapping
			zippedIterator = zip(collection, collection.dropFirst()).makeIterator()

			guard collection.count > 1 else {
				first = nil
				last = nil
				return
			}

			first = collection.first
			last = collection.last
		}
	}
}

extension PairedSequence: Sequence {

	public func makeIterator() -> PairedSequence<Collection>.Iterator {
		return Iterator(collection: collection, wrapping: wrapping)
	}
}

extension PairedSequence.Iterator: IteratorProtocol {

	public mutating func next() -> (Collection.Element, Collection.Element)? {

		guard
			let first = first,
			let last = last
		else {
			return nil
		}

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
	/// - Returns: A sequence of tuples containing paired elements from the receiver.
	func paired(with wrapping: PairedSequence<Self>.Wrapping = .none) -> PairedSequence<Self> {
		return PairedSequence(collection: self, wrapping: wrapping)
	}
}
